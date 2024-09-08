class DailyStreak {
  DailyStreakData data;

  DailyStreak({
    required this.data,
  });

  factory DailyStreak.fromJson(Map<String, dynamic> json) => DailyStreak(
        data: DailyStreakData.fromJson(json['data']),
      );
}

class DailyStreakData {
  DailyStreakStreakCounter streakCounter;

  DailyStreakData({
    required this.streakCounter,
  });

  factory DailyStreakData.fromJson(Map<String, dynamic> json) =>
      DailyStreakData(
        streakCounter: DailyStreakStreakCounter.fromJson(
          json['streakCounter'],
        ),
      );
}

class DailyStreakStreakCounter {
  final int streakCount;
  final int daysSkipped;
  final bool currentDayCompleted;

  DailyStreakStreakCounter({
    required this.streakCount,
    required this.daysSkipped,
    required this.currentDayCompleted,
  });

  factory DailyStreakStreakCounter.fromJson(Map<String, dynamic> json) =>
      DailyStreakStreakCounter(
        streakCount: json['streakCount'],
        daysSkipped: json['daysSkipped'],
        currentDayCompleted: json['currentDayCompleted'],
      );
}
