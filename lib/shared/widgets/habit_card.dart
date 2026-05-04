import 'package:flutter/material.dart';
import 'package:portfolio/shared/widgets/progress_rings.dart';

import '../../core/theme/app_colors.dart';

class HabitCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final double progress; // 0.0 to 1.0
  final int streak;
  final Color color;

  const HabitCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.progress,
    required this.streak,
    this.color = AppColors.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // --- progress ring ---
          ProgressRing(progress: progress, color: color),
          const SizedBox(width: 12),
          // --- habit info ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    )),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    )),
              ],
            ),
          ),
          // --- streak badge ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '🔥 $streak',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}