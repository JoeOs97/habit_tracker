import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class HeatmapWidget extends StatelessWidget {
  final List<DateTime> completedDates;
  const HeatmapWidget({super.key, required this.completedDates});

  @override
  Widget build(BuildContext context) {
    final last30 = List.generate(30, (i) =>
        DateTime.now().subtract(Duration(days: 29 - i)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('LAST 30 DAYS', style: TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary,
          letterSpacing: 0.8,
        )),
        const SizedBox(height: 10),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: last30.map((date) {
            final done = completedDates.any((d) =>
            d.year == date.year &&
                d.month == date.month &&
                d.day == date.day);
            return Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: done ? AppColors.accent : AppColors.surface,
                borderRadius: BorderRadius.circular(6),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

  Color _colorForLevel(int level) {
    switch (level) {
      case 1: return const Color(0xff3d2e6b);
      case 2: return const Color(0xff6b4fcb);
      case 3: return AppColors.accent;
      default: return AppColors.surface;
    }
  }