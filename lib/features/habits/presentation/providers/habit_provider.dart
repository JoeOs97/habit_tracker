import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';

import '../../data/habit_model.dart';

class HabitNotifier extends StateNotifier<List<Habit>>{

  HabitNotifier() : super([
  ]);

  void addHabit(Habit habit) {
    state = [...state, habit];
  }
  void toggleDone(String id){
    final today = DateTime.now();
    state = state.map((habit) {
      if(habit.id != id) return habit;

      final alreadyDone = habit.completedDates.any((d) =>
          d.year == today.year &&
          d.month == today.month &&
          d.day == today.day
      );
      final updatedDates = alreadyDone
          ? habit.completedDates
          .where((d) => !(d.year == today.year &&
          d.month == today.month &&
          d.day == today.day))
          .toList()
          : [...habit.completedDates, today];

      return habit.copyWith(
        isDone: !alreadyDone,
        completedDates: updatedDates,
      );
    }).toList();
  }
}

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) => HabitNotifier());