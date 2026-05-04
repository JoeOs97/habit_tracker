import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';

import '../../data/habit_model.dart';

class HabitNotifier extends StateNotifier<List<Habit>>{

  HabitNotifier() : super([
    Habit(
      id: '1',
      name: 'Morning run',
      subtitle: 'Daily · 6:00 AM',
      color: const Color(0xffA78BFA),
      progress: 0.75,
      streak: 7,
    ),
    Habit(
      id: '2',
      name: 'Read 20 pages',
      subtitle: 'Daily · Any time',
      color: const Color(0xff34D399),
      progress: 1.0,
      streak: 21,
    ),
    Habit(
      id: '3',
      name: 'Meditate',
      subtitle: 'Daily · 10 min',
      color: const Color(0xffF87171),
      progress: 0.25,
      streak: 3,
    ),
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