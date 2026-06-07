import 'dart:convert';

class DashboardResponseModel {
    final String? status;
    final Dashboard? dashboard;

    DashboardResponseModel({
        this.status,
        this.dashboard,
    });

    factory DashboardResponseModel.fromJson(String str) => DashboardResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    // 🔥 PERBAIKAN DI SINI: json["dashboard"] diganti menjadi json["data"]
    factory DashboardResponseModel.fromMap(Map<String, dynamic> json) => DashboardResponseModel(
        status: json["status"],
        dashboard: json["data"] == null ? null : Dashboard.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": dashboard?.toMap(),
    };
}

class Dashboard {
    final User? user;
    final Summary? summary;
    final List<TodayHabit>? todayHabits;

    Dashboard({
        this.user,
        this.summary,
        this.todayHabits,
    });

    factory Dashboard.fromJson(String str) => Dashboard.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dashboard.fromMap(Map<String, dynamic> json) => Dashboard(
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        summary: json["summary"] == null ? null : Summary.fromMap(json["summary"]),
        todayHabits: json["today_habits"] == null ? [] : List<TodayHabit>.from(json["today_habits"]!.map((x) => TodayHabit.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "user": user?.toMap(),
        "summary": summary?.toMap(),
        "today_habits": todayHabits == null ? [] : List<dynamic>.from(todayHabits!.map((x) => x.toMap())),
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

    factory TodayHabit.fromJson(String str) => TodayHabit.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory TodayHabit.fromMap(Map<String, dynamic> json) => TodayHabit(
        userHabitId: json["user_habit_id"],
        habitName: json["habit_name"],
        streak: json["streak"],
        isCompletedToday: json["is_completed_today"],
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

    User({
        this.name,
        this.diamonds,
    });

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        diamonds: json["diamonds"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "diamonds": diamonds,
    };
}