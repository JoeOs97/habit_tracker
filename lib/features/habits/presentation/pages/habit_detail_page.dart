import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/habits/presentation/providers/habit_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/heatmap.dart';
import '../../../../shared/widgets/summary_card.dart';
import '../../data/habit_model.dart';

class HabitDetailPage extends ConsumerWidget{
  final Habit habit;
  const HabitDetailPage({super.key,required this.habit});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final habits = ref.watch(habitProvider);
    final currentHabit = habits.firstWhere((h) => h.id == habit.id);
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    habit.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: SummaryCard(value: '${currentHabit.currentStreak}', label: 'Streak'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: SummaryCard(value: '${(currentHabit.completionRate * 100).toInt()}%', label: 'Completion'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: SummaryCard(value: currentHabit.isDone ? 'Done' : 'Pending', label: 'Today'),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Text('THIS WEEK', style: TextStyle(
                fontSize: 11,color: AppColors.textSecondary, letterSpacing: 0.8
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final day = DateTime.now().subtract(
                    Duration(days: DateTime.now().weekday - 1 - index));
                final isDone = currentHabit.isCompletedOn(day);
                final labels = ['M','T','W','T','F','S','S'];
                return Column(
                  children: [
                    Text(labels[index], style: const TextStyle(
                        fontSize: 10, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.accent : AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: isDone
                          ? const Icon(Icons.check_rounded,
                          size: 12, color: AppColors.background)
                          : null,
                    ),
                  ],
                );
              },),
              ),
              const SizedBox(height: 20,),
              HeatmapWidget(completedDates: currentHabit.completedDates),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Mark today as done',
                        style: TextStyle(
                            fontSize: 13, color: AppColors.textPrimary)),
                    Switch(
                      value: currentHabit.isDone,
                      onChanged: (val) {
                        ref.read(habitProvider.notifier).toggleDone(currentHabit.id);
                      },
                      activeColor: AppColors.accent,
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      )) ,
    );
  }
}