import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mino/core/data/model/response/dashboard_response.dart';

class DashboardLocalDatasource {
  DashboardLocalDatasource._init();
  static final DashboardLocalDatasource instance =
      DashboardLocalDatasource._init();

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
    // Diubah ke version: 2 karena ada struktur kolom baru untuk Progress
    return openDatabase(databasePath, version: 2, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  // Tambahkan fungsi onUpgrade jika user lama melakukan update database
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
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
        -- 🔥 KOLOM BARU UNTUK FITUR PROGRESS
        progress_month TEXT,
        weekly_goal_percent REAL,
        monthly_goal_percent REAL,
        weekly_bars_json TEXT 
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

  // 🔥 UPDATE PROSES CACHE AGAR DATA PROGRESS IKUT TERSIMPAN
  Future<void> cacheDashboard(DashboardResponseModel responseModel) async {
    final db = await instance.database;
    final dashboard = responseModel.dashboard;
    if (dashboard == null) return;

    String todayDate = DateTime.now().toString().split(' ')[0];

    await db.delete(tableSummary);
    await db.delete(tableHabits);

    await db.insert(tableSummary, {
      'id': 1,
      'user_name': dashboard.user?.name ?? 'User',
      'diamonds': dashboard.user?.diamonds ?? 0,
      'habits_total': dashboard.summary?.habitsTotal ?? 0,
      'habits_completed_today': dashboard.summary?.habitsCompletedToday ?? 0,
      'focus_minutes_today': dashboard.summary?.focusMinutesToday ?? 0,
      'has_reflected_today': (dashboard.summary?.hasReflectedToday ?? false) ? 1 : 0,
      'last_updated_date': todayDate,
      // 🔥 SIMPAN PROGRESS NYATA DARI LARAVEL KE SQLITE
      'progress_month': dashboard.progress?.month ?? '',
      'weekly_goal_percent': dashboard.progress?.weeklyGoalPercent ?? 0.0,
      'monthly_goal_percent': dashboard.progress?.monthlyGoalPercent ?? 0.0,
      'weekly_bars_json': jsonEncode(dashboard.progress?.weeklyBars ?? []), // Di-encode jadi String JSON
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

  // 🔥 UPDATE AMBIL DATA LOCAL (OFFLINE)
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
            // Saat ganti hari offline, persen hari ini disesuaikan
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

      // Decode kembali list array diagram mingguan dari SQLITE String
      List<dynamic> decodedBars = jsonDecode(localSummary['weekly_bars_json'] ?? '[]');
      List<double> weeklyBarsList = decodedBars.map((e) => (e as num).toDouble()).toList();

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
          // 🔥 KEMBALIKAN DATA PROGRESS DARI SQLITE LOKAL KETIKA OFFLINE
          progress: Progress(
            month: localSummary['progress_month'],
            weeklyGoalPercent: localSummary['weekly_goal_percent'],
            monthlyGoalPercent: localSummary['monthly_goal_percent'],
            weeklyBars: weeklyBarsList,
          ),
          todayHabits: habitsList,
        ),
      );

      return Right(dashboardResponse);
    } catch (e) {
      return Left('Gagal memuat data lokal: $e');
    }
  }

  // 🔥 3. OFFLINE TOGGLE STATUS HABIT
  // 🔥 UPDATE FUNGSI TOGGLE DI DASHBOARD LOCAL DATASOURCE
  Future<bool> toggleLocalHabitStatus(
    int userHabitId,
    bool currentStatus,
  ) async {
    try {
      final db = await instance.database;
      int newStatus = currentStatus ? 0 : 1;

      // 1. Update status habit-nya
      await db.update(
        tableHabits,
        {'is_completed_today': newStatus},
        where: 'user_habit_id = ?',
        whereArgs: [userHabitId],
      );

      // 2. Update hitungan summary & DIAMOND secara lokal
      final List<Map<String, dynamic>> summaryMaps = await db.query(
        tableSummary,
        where: 'id = ?',
        whereArgs: [1],
      );
      if (summaryMaps.isNotEmpty) {
        int currentCompleted = summaryMaps.first['habits_completed_today'] ?? 0;
        int currentDiamonds =
            summaryMaps.first['diamonds'] ?? 0; // 🔥 Ambil diamond saat ini

        // Jika status awal FALSE (berarti sekarang dicentang/selesai), DIAMOND TAMBAH 10
        // Jika status awal TRUE (berarti centang dibatalkan), DIAMOND KURANG 10
        int newCompleted = currentStatus
            ? (currentCompleted - 1)
            : (currentCompleted + 1);
        int newDiamonds = currentStatus
            ? (currentDiamonds - 10)
            : (currentDiamonds +
                  10); // 💎 Sesuaikan hadiah diamond projekmu di sini

        await db.update(
          tableSummary,
          {
            'habits_completed_today': newCompleted < 0 ? 0 : newCompleted,
            'diamonds': newDiamonds < 0
                ? 0
                : newDiamonds, // 🔥 UPDATE UTAMA: Diamond ikut disimpan ke SQLite
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

  // 🔥 4. OFFLINE ADD HABIT
  Future<bool> addLocalHabit(String name) async {
    try {
      final db = await instance.database;
      await db.insert(tableHabits, {
        'habit_name': name,
        'streak': 0,
        'is_completed_today': 0,
      });

      // Update total habit di summary lokal
      await db.rawUpdate(
        'UPDATE $tableSummary SET habits_total = habits_total + 1 WHERE id = 1',
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // 🔥 5. OFFLINE EDIT HABIT
  Future<bool> editLocalHabit(int userHabitId, String newName) async {
    try {
      final db = await instance.database;
      final result = await db.update(
        tableHabits,
        {'habit_name': newName},
        where: 'user_habit_id = ?',
        whereArgs: [userHabitId],
      );
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  // 🔥 6. OFFLINE DELETE HABIT
  Future<bool> deleteLocalHabit(int userHabitId) async {
    try {
      final db = await instance.database;

      // Ambil data untuk tahu status kelayakannya sebelum dihapus
      final List<Map<String, dynamic>> habit = await db.query(
        tableHabits,
        where: 'user_habit_id = ?',
        whereArgs: [userHabitId],
      );
      if (habit.isEmpty) return false;
      bool isCompleted = habit.first['is_completed_today'] == 1;

      await db.delete(
        tableHabits,
        where: 'user_habit_id = ?',
        whereArgs: [userHabitId],
      );

      // Kurangi habits_total & habits_completed jika yang dihapus statusnya sudah kelar hari ini
      if (isCompleted) {
        await db.rawUpdate(
          'UPDATE $tableSummary SET habits_total = habits_total - 1, habits_completed_today = habits_completed_today - 1 WHERE id = 1',
        );
      } else {
        await db.rawUpdate(
          'UPDATE $tableSummary SET habits_total = habits_total - 1 WHERE id = 1',
        );
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
