import 'package:flutter/material.dart';

class Habit {
  final String id;
  final String name;
  final String subtitle;
  final Color color;
  final double progress; // 0.0 to 1.0
  final int streak;
  final bool isDone;
  final List<DateTime> completedDates;

  Habit({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.color,
    required this.progress,
    required this.streak,
    this.isDone = false,
    this.completedDates = const [],
  });
  Habit copyWith({
    String? name,
    String? subtitle,
    Color? color,
    double? progress,
    int? streak,
    bool? isDone,
    List<DateTime>? completedDates,
}){
    return Habit(
      id: id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      color: color ?? this.color,
      progress: progress ?? this.progress,
      streak: streak ?? this.streak,
      isDone: isDone ?? this.isDone,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  // check if completed on a specific day
  bool isCompletedOn(DateTime date) {
    return completedDates.any((d) =>
    d.year == date.year &&
        d.month == date.month &&
        d.day == date.day);
  }

// current streak — count consecutive days backwards from today
  int get currentStreak {
    int streak = 0;
    DateTime day = DateTime.now();
    while (isCompletedOn(day)) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    return streak;
  }

// completion % over last 30 days
  double get completionRate {
    if (completedDates.isEmpty) return 0.0;
    final last30 = List.generate(30, (i) =>
        DateTime.now().subtract(Duration(days: i)));
    final done = last30.where((d) => isCompletedOn(d)).length;
    return done / 30;
  }
}