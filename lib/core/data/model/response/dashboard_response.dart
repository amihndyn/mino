import 'dart:convert';

class DashboardResponseModel {
  final String? status;
  final Dashboard? dashboard;

  DashboardResponseModel({this.status, this.dashboard});

  DashboardResponseModel copyWith({
    String? status,
    Dashboard? dashboard,
  }) {
    return DashboardResponseModel(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
    );
  }

  factory DashboardResponseModel.fromJson(String str) =>
      DashboardResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DashboardResponseModel.fromMap(Map<String, dynamic> json) =>
      DashboardResponseModel(
        status: json["status"],
        dashboard: json["data"] == null
            ? null
            : Dashboard.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": dashboard?.toMap(),
      };
}

class Dashboard {
  final User? user;
  final Summary? summary;
  final Progress? progress;
  final List<TodayHabit>? todayHabits;

  Dashboard({this.user, this.summary, this.progress, this.todayHabits});

  Dashboard copyWith({
    User? user,
    Summary? summary,
    Progress? progress,
    List<TodayHabit>? todayHabits,
  }) {
    return Dashboard(
      user: user ?? this.user,
      summary: summary ?? this.summary,
      progress: progress ?? this.progress,
      todayHabits: todayHabits ?? this.todayHabits,
    );
  }

  factory Dashboard.fromJson(String str) => Dashboard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dashboard.fromMap(Map<String, dynamic> json) => Dashboard(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        summary: json["summary"] == null ? null : Summary.fromMap(json["summary"]),
        progress: json["progress"] == null ? null : Progress.fromMap(json["progress"]),
        todayHabits: json["today_habits"] == null
            ? []
            : List<TodayHabit>.from(
                json["today_habits"]!.map((x) => TodayHabit.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
        "summary": summary?.toMap(),
        "progress": progress?.toMap(),
        "today_habits": todayHabits == null
            ? []
            : List<dynamic>.from(todayHabits!.map((x) => x.toMap())),
      };
}

class Progress {
  final String? month;
  final int? selectedMonthId; 
  final double? weeklyGoalPercent;
  final double? monthlyGoalPercent;
  final List<double>? weeklyBars;
  final List<double>? monthlyBars;
  final List<AllMonth>? allMonths; 

  Progress({
    this.month,
    this.selectedMonthId,
    this.weeklyGoalPercent,
    this.monthlyGoalPercent,
    this.weeklyBars,
    this.monthlyBars,
    this.allMonths,
  });

  factory Progress.fromMap(Map<String, dynamic> json) {
    // 🔥 AMAN: Cek apakah selected_month_id datang berupa int atau String
    final rawMonthId = json["selected_month_id"];
    int? parsedMonthId = rawMonthId is int 
        ? rawMonthId 
        : int.tryParse(rawMonthId?.toString() ?? '');

    return Progress(
      month: json["month"],
      selectedMonthId: parsedMonthId, // Menggunakan hasil parsing yang aman
      weeklyGoalPercent: (json["weekly_goal_percent"] as num?)?.toDouble(),
      monthlyGoalPercent: (json["monthly_goal_percent"] as num?)?.toDouble(),
      weeklyBars: json["weekly_bars"] == null
          ? []
          : List<double>.from(json["weekly_bars"]!.map((x) => (x as num).toDouble())),
      monthlyBars: json["monthly_bars"] == null
          ? []
          : List<double>.from(json["monthly_bars"]!.map((x) => (x as num).toDouble())),
      allMonths: json["all_months"] == null
          ? []
          : List<AllMonth>.from(json["all_months"]!.map((x) => AllMonth.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        "month": month,
        "selected_month_id": selectedMonthId,
        "weekly_goal_percent": weeklyGoalPercent,
        "monthly_goal_percent": monthlyGoalPercent,
        "weekly_bars": weeklyBars == null 
            ? [] 
            : List<dynamic>.from(weeklyBars!.map((x) => x)),
        "monthly_bars": monthlyBars == null ? [] : List<dynamic>.from(monthlyBars!.map((x) => x)),
        "all_months": allMonths == null
            ? []
            : List<dynamic>.from(allMonths!.map((x) => x.toMap())),
      };
}

class AllMonth {
  final int? id;
  final String? name;

  AllMonth({this.id, this.name});

  factory AllMonth.fromMap(Map<String, dynamic> json) {
    // 🔥 AMAN: Parsing ID bulan di dalam list dropdown/filter bulanan
    final rawId = json["id"];
    int? parsedId = rawId is int ? rawId : int.tryParse(rawId?.toString() ?? '');

    return AllMonth(
      id: parsedId,
      name: json["name"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Summary {
  final int? habitsTotal;
  final int? habitsCompletedToday;
  final int? focusMinutesToday;
  final bool? hasReflectedToday;

  Summary({
    this.habitsTotal,
    this.habitsCompletedToday,
    this.focusMinutesToday,
    this.hasReflectedToday,
  });

  factory Summary.fromMap(Map<String, dynamic> json) {
    // 🔥 AMAN: Parsing data ringkasan habit/menit fokus harian
    final rawTotal = json["habits_total"];
    final rawCompleted = json["habits_completed_today"];
    final rawFocus = json["focus_minutes_today"];

    return Summary(
      habitsTotal: rawTotal is int ? rawTotal : int.tryParse(rawTotal?.toString() ?? ''),
      habitsCompletedToday: rawCompleted is int ? rawCompleted : int.tryParse(rawCompleted?.toString() ?? ''),
      focusMinutesToday: rawFocus is int ? rawFocus : int.tryParse(rawFocus?.toString() ?? ''),
      hasReflectedToday: json["has_reflected_today"] is bool 
          ? json["has_reflected_today"] 
          : (json["has_reflected_today"] == 1 || json["has_reflected_today"] == "true"),
    );
  }

  Map<String, dynamic> toMap() => {
        "habits_total": habitsTotal,
        "habits_completed_today": habitsCompletedToday,
        "focus_minutes_today": focusMinutesToday,
        "has_reflected_today": hasReflectedToday,
      };
}

class TodayHabit {
  final int? userHabitId;
  final String? habitName;
  final int? streak;
  final bool? isCompletedToday;

  TodayHabit({
    this.userHabitId,
    this.habitName,
    this.streak,
    this.isCompletedToday,
  });

  factory TodayHabit.fromMap(Map<String, dynamic> json) {
    bool? parsedCompleted;
    if (json["is_completed_today"] != null) {
      if (json["is_completed_today"] is bool) {
        parsedCompleted = json["is_completed_today"];
      } else if (json["is_completed_today"] is num) {
        parsedCompleted = json["is_completed_today"] == 1;
      } else if (json["is_completed_today"] is String) {
        parsedCompleted = json["is_completed_today"] == "true" || json["is_completed_today"] == "1";
      }
    }

    // 🔥 AMAN: Parsing user_habit_id dan data streak bawaan habit
    final rawHabitId = json["user_habit_id"];
    final rawStreak = json["streak"];

    return TodayHabit(
      userHabitId: rawHabitId is int ? rawHabitId : int.tryParse(rawHabitId?.toString() ?? ''),
      habitName: json["custom_name"] ?? json["habit_name"],
      streak: rawStreak is int ? rawStreak : int.tryParse(rawStreak?.toString() ?? ''),
      isCompletedToday: parsedCompleted ?? false,
    );
  }

  factory TodayHabit.fromLocalMap(Map<String, dynamic> json) => TodayHabit(
        userHabitId: json["user_habit_id"],
        habitName: json["habit_name"],
        streak: json["streak"],
        isCompletedToday: json["is_completed_today"] == 1, 
      );

  Map<String, dynamic> toMap() => {
        "user_habit_id": userHabitId,
        "habit_name": habitName,
        "streak": streak,
        "is_completed_today": isCompletedToday,
      };
}

class User {
  final String? name;
  final int? diamonds;

  User({this.name, this.diamonds});

  factory User.fromMap(Map<String, dynamic> json) {
    // 🔥 AMAN: Parsing data saldo diamond milik user
    final rawDiamonds = json["diamonds"];
    int? parsedDiamonds = rawDiamonds is int ? rawDiamonds : int.tryParse(rawDiamonds?.toString() ?? '');

    return User(
      name: json["name"], 
      diamonds: parsedDiamonds,
    );
  }

  Map<String, dynamic> toMap() => {"name": name, "diamonds": diamonds};
}