import 'package:flutter/material.dart';

class Habit {
  final String id;
  final String name;
  final String subtitle;
  final Color color;
  final double progress; // 0.0 to 1.0
  final int streak;
  final bool isDone;

  Habit({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.color,
    required this.progress,
    required this.streak,
    this.isDone = false,
  });
  Habit copyWith({
    String? name,
    String? subtitle,
    Color? color,
    double? progress,
    int? streak,
    bool? isDone,
}){
    return Habit(
      id: id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      color: color ?? this.color,
      progress: progress ?? this.progress,
      streak: streak ?? this.streak,
      isDone: isDone ?? this.isDone,
    );
  }
}