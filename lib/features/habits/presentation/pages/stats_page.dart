import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/habit_card.dart';
import '../../../../shared/widgets/summary_card.dart';
import '../providers/habit_provider.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);
    final totalHabits = habits.length;
    final totalCompletions = habits
        .expand((h) => h.completedDates)
        .length;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Stats', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              )),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: SummaryCard(
                    value: '$totalHabits',
                    label: 'Active habits',
                  )),
                  const SizedBox(width: 10),
                  Expanded(child: SummaryCard(
                    value: '$totalCompletions',
                    label: 'Total completions',
                  )),
                ],
              ),
              const SizedBox(height: 20),
              const Text('WEEKLY COMPLETION', style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                letterSpacing: 0.8,
              )),
              const SizedBox(height: 10),
              Container(
                height: 120,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    final day = DateTime.now().subtract(
                        Duration(days: DateTime.now().weekday - 1 - index));
                    final labels = ['M','T','W','T','F','S','S'];
                    final count = habits
                        .where((h) => h.isCompletedOn(day))
                        .length;
                    const maxHeight = 70.0;
                    final barHeight = habits.isEmpty
                        ? 0.0
                        : (count / habits.length) * maxHeight;
                    final isToday = index == DateTime.now().weekday - 1;

                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: barHeight + 4,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: isToday
                                  ? AppColors.accent
                                  : AppColors.accentDark,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(labels[index], style: const TextStyle(
                              fontSize: 9,
                              color: AppColors.textSecondary)),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              const Text('TOP HABITS', style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                letterSpacing: 0.8,
              )),
              const SizedBox(height: 10),
              habits.isEmpty
                  ? const Center(
                  child: Text('No habits yet',
                      style: TextStyle(color: AppColors.textSecondary)))
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: habits.length,
                itemBuilder: (context, index) => HabitCard(
                  name: habits[index].name,
                  subtitle: habits[index].subtitle,
                  progress: habits[index].completionRate,
                  streak: habits[index].currentStreak,
                  color: habits[index].color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}