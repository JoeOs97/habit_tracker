import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/habit_card.dart';
import '../../../../shared/widgets/heatmap.dart';
import '../../../../shared/widgets/summary_card.dart';
import '../providers/habit_provider.dart';
import 'add_habit_page.dart';
import 'habit_detail_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Morning',
                style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Youssef',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddHabitPage()));
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.background,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(
                    child: SummaryCard(value: '4/6', label: 'Today'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(value: '12', label: 'Best streak'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SummaryCard(value: '83%', label: 'This week'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              HeatmapWidget(
                completedDates: habits
                    .expand((h) => h.completedDates)
                    .toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'TODAY\'S HABITS',
                style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.8),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: habits.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HabitDetailPage(habit: habits[index]),
                      ),
                    ),
                    child: HabitCard(
                      name: habits[index].name,
                      subtitle: habits[index].subtitle,
                      progress: habits[index].progress,
                      streak: habits[index].streak,
                      color: habits[index].color,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: 0,
      ),
    );
  }
}
