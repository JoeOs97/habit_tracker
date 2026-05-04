import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final String value;
  final String label;
  const SummaryCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.accent)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(
              fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}