import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';

class DashboardLocalDatasource {
  DashboardLocalDatasource._init();
  static final DashboardLocalDatasource instance = DashboardLocalDatasource._init();

  static Database? _database;

  final String tableSummary = 'dashboard_summary';
  final String tableHabits = 'today_habits';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/mino_dashboard.db';
    // 🔥 FIX: Diubah ke versi 3 karena ada struktur kolom baru untuk Progress Bulanan
    return openDatabase(databasePath, version: 3, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // 🔥 FIX: Jika user punya DB lama (v1 atau v2), drop dan create ulang agar kolom baru masuk
    if (oldVersion < 3) {
      await db.execute('DROP TABLE IF EXISTS $tableSummary');
      await db.execute('DROP TABLE IF EXISTS $tableHabits');
      await _createDB(db, newVersion);
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableSummary(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_name TEXT,
        diamonds INTEGER,
        habits_total INTEGER,
        habits_completed_today INTEGER,
        focus_minutes_today INTEGER,
        has_reflected_today INTEGER,
        last_updated_date TEXT,
        progress_month TEXT,
        weekly_goal_percent REAL,
        monthly_goal_percent REAL,
        weekly_bars_json TEXT,
        -- 🔥 FIX: KOLOM BARU UNTUK PROGRESS BULANAN & FILTER BULAN
        selected_month_id INTEGER,
        monthly_bars_json TEXT,
        all_months_json TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableHabits(
        user_habit_id INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_name TEXT NOT NULL,
        streak INTEGER DEFAULT 0,
        is_completed_today INTEGER DEFAULT 0
      )
    ''');
  }

  // 🔥 FIX: PROSES CACHE SEKARANG MENYIMPAN DATA BULANAN UTUH
  Future<void> cacheDashboard(DashboardResponseModel responseModel) async {
    final db = await instance.database;
    final dashboard = responseModel.dashboard;
    if (dashboard == null) return;

    String todayDate = DateTime.now().toString().split(' ')[0];

    await db.delete(tableSummary);
    await db.delete(tableHabits);

    // Encode objek list ke bentuk String JSON agar bisa masuk SQLite
    String weeklyBarsJson = jsonEncode(dashboard.progress?.weeklyBars ?? []);
    String monthlyBarsJson = jsonEncode(dashboard.progress?.monthlyBars ?? []);
    String allMonthsJson = jsonEncode(dashboard.progress?.allMonths?.map((e) => e.toMap()).toList() ?? []);

    await db.insert(tableSummary, {
      'id': 1,
      'user_name': dashboard.user?.name ?? 'User',
      'diamonds': dashboard.user?.diamonds ?? 0,
      'habits_total': dashboard.summary?.habitsTotal ?? 0,
      'habits_completed_today': dashboard.summary?.habitsCompletedToday ?? 0,
      'focus_minutes_today': dashboard.summary?.focusMinutesToday ?? 0,
      'has_reflected_today': (dashboard.summary?.hasReflectedToday ?? false) ? 1 : 0,
      'last_updated_date': todayDate,
      'progress_month': dashboard.progress?.month ?? '',
      'weekly_goal_percent': dashboard.progress?.weeklyGoalPercent ?? 0.0,
      'monthly_goal_percent': dashboard.progress?.monthlyGoalPercent ?? 0.0,
      'weekly_bars_json': weeklyBarsJson,
      // 🔥 FIX: MASUKKAN DATA BULANAN KE SQLITE
      'selected_month_id': dashboard.progress?.selectedMonthId,
      'monthly_bars_json': monthlyBarsJson,
      'all_months_json': allMonthsJson,
    });

    if (dashboard.todayHabits != null) {
      for (var habit in dashboard.todayHabits!) {
        await db.insert(tableHabits, {
          'user_habit_id': habit.userHabitId,
          'habit_name': habit.habitName,
          'streak': habit.streak ?? 0,
          'is_completed_today': (habit.isCompletedToday ?? false) ? 1 : 0,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  // 🔥 FIX: AMBIL DATA LOCAL OFFLINE SEKARANG MENGEMBALIKAN PROGRESS BULANAN UTUH
  Future<Either<String, DashboardResponseModel>> getLocalDashboard() async {
    try {
      final db = await instance.database;
      final List<Map<String, dynamic>> summaryMaps = await db.query(tableSummary, where: 'id = ?', whereArgs: [1]);

      if (summaryMaps.isEmpty) {
        return const Left('Data lokal kosong, silakan login/hubungkan ke internet terlebih dahulu.');
      }

      String todayDate = DateTime.now().toString().split(' ')[0];
      String lastSavedDate = summaryMaps.first['last_updated_date'] ?? '';
      Map<String, dynamic> localSummary = summaryMaps.first;

      if (lastSavedDate != todayDate && lastSavedDate.isNotEmpty) {
        await db.update(tableHabits, {'is_completed_today': 0});
        await db.update(
          tableSummary,
          {
            'habits_completed_today': 0,
            'last_updated_date': todayDate,
            'weekly_goal_percent': 0.0, 
          },
          where: 'id = ?',
          whereArgs: [1],
        );

        final List<Map<String, dynamic>> updatedSummaryMaps = await db.query(tableSummary, where: 'id = ?', whereArgs: [1]);
        localSummary = updatedSummaryMaps.first;
      }

      final List<Map<String, dynamic>> habitMaps = await db.query(tableHabits);
      final List<TodayHabit> habitsList = habitMaps.map((e) => TodayHabit.fromLocalMap(e)).toList();

      // 🔥 FIX: Decode kembali data grafik mingguan dan bulanan dari SQLite String
      List<dynamic> decodedWeeklyBars = jsonDecode(localSummary['weekly_bars_json'] ?? '[]');
      List<double> weeklyBarsList = decodedWeeklyBars.map((e) => (e as num).toDouble()).toList();

      List<dynamic> decodedMonthlyBars = jsonDecode(localSummary['monthly_bars_json'] ?? '[]');
      List<double> monthlyBarsList = decodedMonthlyBars.map((e) => (e as num).toDouble()).toList();

      List<dynamic> decodedAllMonths = jsonDecode(localSummary['all_months_json'] ?? '[]');
      List<AllMonth> allMonthsList = decodedAllMonths.map((e) => AllMonth.fromMap(e)).toList();

      final dashboardResponse = DashboardResponseModel(
        status: "success",
        dashboard: Dashboard(
          user: User(
            name: localSummary['user_name'],
            diamonds: localSummary['diamonds'],
          ),
          summary: Summary(
            habitsTotal: localSummary['habits_total'],
            habitsCompletedToday: localSummary['habits_completed_today'],
            focusMinutesToday: localSummary['focus_minutes_today'],
            hasReflectedToday: localSummary['has_reflected_today'] == 1,
          ),
          // 🔥 FIX: Mengembalikan object progress secara lengkap saat offline
          progress: Progress(
            month: localSummary['progress_month'],
            selectedMonthId: localSummary['selected_month_id'],
            weeklyGoalPercent: localSummary['weekly_goal_percent'],
            monthlyGoalPercent: localSummary['monthly_goal_percent'],
            weeklyBars: weeklyBarsList,
            monthlyBars: monthlyBarsList,
            allMonths: allMonthsList,
          ),
          todayHabits: habitsList,
        ),
      );

      return Right(dashboardResponse);
    } catch (e) {
      return Left('Gagal memuat data lokal: $e');
    }
  }

  // --- Fungsi toggleLocalHabitStatus, addLocalHabit, editLocalHabit, deleteLocalHabit tetap sama ---
  Future<bool> toggleLocalHabitStatus(int userHabitId, bool currentStatus) async {
    try {
      final db = await instance.database;
      int newStatus = currentStatus ? 0 : 1;
      await db.update(tableHabits, {'is_completed_today': newStatus}, where: 'user_habit_id = ?', whereArgs: [userHabitId]);

      final List<Map<String, dynamic>> summaryMaps = await db.query(tableSummary, where: 'id = ?', whereArgs: [1]);
      if (summaryMaps.isNotEmpty) {
        int currentCompleted = summaryMaps.first['habits_completed_today'] ?? 0;
        int currentDiamonds = summaryMaps.first['diamonds'] ?? 0;

        int newCompleted = currentStatus ? (currentCompleted - 1) : (currentCompleted + 1);
        int newDiamonds = currentStatus ? (currentDiamonds - 10) : (currentDiamonds + 10);

        await db.update(
          tableSummary,
          {
            'habits_completed_today': newCompleted < 0 ? 0 : newCompleted,
            'diamonds': newDiamonds < 0 ? 0 : newDiamonds,
          },
          where: 'id = ?',
          whereArgs: [1],
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addLocalHabit(String name) async {
    try {
      final db = await instance.database;
      await db.insert(tableHabits, {'habit_name': name, 'streak': 0, 'is_completed_today': 0});
      await db.rawUpdate('UPDATE $tableSummary SET habits_total = habits_total + 1 WHERE id = 1');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editLocalHabit(int userHabitId, String newName) async {
    try {
      final db = await instance.database;
      final result = await db.update(tableHabits, {'habit_name': newName}, where: 'user_habit_id = ?', whereArgs: [userHabitId]);
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteLocalHabit(int userHabitId) async {
    try {
      final db = await instance.database;
      final List<Map<String, dynamic>> habit = await db.query(tableHabits, where: 'user_habit_id = ?', whereArgs: [userHabitId]);
      if (habit.isEmpty) return false;
      bool isCompleted = habit.first['is_completed_today'] == 1;

      await db.delete(tableHabits, where: 'user_habit_id = ?', whereArgs: [userHabitId]);

      if (isCompleted) {
        await db.rawUpdate('UPDATE $tableSummary SET habits_total = habits_total - 1, habits_completed_today = habits_completed_today - 1 WHERE id = 1');
      } else {
        await db.rawUpdate('UPDATE $tableSummary SET habits_total = habits_total - 1 WHERE id = 1');
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}