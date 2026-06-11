import 'dart:convert';

class DashboardResponseModel {
  final String? status;
  final Dashboard? dashboard;

  DashboardResponseModel({this.status, this.dashboard});

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
  final int? selectedMonthId; // 🔥 Tambahkan ini untuk melacak ID bulan aktif
  final double? weeklyGoalPercent;
  final double? monthlyGoalPercent;
  final List<double>? weeklyBars;
  final List<double>? monthlyBars;
  final List<AllMonth>? allMonths; // 🔥 Tambahkan list objek bulan dari Laravel

  Progress({
    this.month,
    this.selectedMonthId,
    this.weeklyGoalPercent,
    this.monthlyGoalPercent,
    this.weeklyBars,
    this.monthlyBars,
    this.allMonths,
  });

  factory Progress.fromMap(Map<String, dynamic> json) => Progress(
        month: json["month"],
        selectedMonthId: json["selected_month_id"], // 🔥 Mapping ID bulan aktif
        weeklyGoalPercent: (json["weekly_goal_percent"] as num?)?.toDouble(),
        monthlyGoalPercent: (json["monthly_goal_percent"] as num?)?.toDouble(),
        weeklyBars: json["weekly_bars"] == null
            ? []
            : List<double>.from(json["weekly_bars"]!.map((x) => (x as num).toDouble())),
        // 🔥 Mapping list all_months dari JSON Laravel
        monthlyBars: json["monthly_bars"] == null
            ? []
            : List<double>.from(json["monthly_bars"]!.map((x) => (x as num).toDouble())),
        allMonths: json["all_months"] == null
            ? []
            : List<AllMonth>.from(json["all_months"]!.map((x) => AllMonth.fromMap(x))),
      );

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

// 🔥 TAMBAHKAN CLASS BARU INI DI PALING BAWAH AGAR FLUTTER BISA MEMBACA ID & NAMA BULAN
class AllMonth {
  final int? id;
  final String? name;

  AllMonth({this.id, this.name});

  factory AllMonth.fromMap(Map<String, dynamic> json) => AllMonth(
        id: json["id"],
        name: json["name"],
      );

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

  factory Summary.fromJson(String str) => Summary.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Summary.fromMap(Map<String, dynamic> json) => Summary(
        habitsTotal: json["habits_total"],
        habitsCompletedToday: json["habits_completed_today"],
        focusMinutesToday: json["focus_minutes_today"],
        hasReflectedToday: json["has_reflected_today"],
      );

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

  factory TodayHabit.fromJson(String str) =>
      TodayHabit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TodayHabit.fromMap(Map<String, dynamic> json) => TodayHabit(
        userHabitId: json["user_habit_id"],
        habitName: json["custom_name"] ?? json["habit_name"],
        streak: json["streak"],
        isCompletedToday: json["is_completed_today"],
      );

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

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) =>
      User(name: json["name"], diamonds: json["diamonds"]);

  Map<String, dynamic> toMap() => {"name": name, "diamonds": diamonds};
}