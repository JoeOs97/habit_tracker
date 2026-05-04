import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class HeatmapWidget extends StatelessWidget {
  const HeatmapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 0 = empty, 1 = light, 2 = medium, 3 = full
    final data = [
      3,1,2,3,0,2,3,
      1,3,2,3,3,1,2,
      3,0,2,3,1,3,2,
      3,2,1,3,3,2,3,
    ];

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
          children: data.map((level) {
            return Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _colorForLevel(level),
                borderRadius: BorderRadius.circular(6),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _colorForLevel(int level) {
    switch (level) {
      case 1: return const Color(0xff3d2e6b);
      case 2: return const Color(0xff6b4fcb);
      case 3: return AppColors.accent;
      default: return AppColors.surface;
    }
  }
}