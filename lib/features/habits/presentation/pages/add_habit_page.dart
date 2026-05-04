import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/features/habits/presentation/providers/habit_provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/habit_model.dart';

class AddHabitPage extends ConsumerStatefulWidget {
  const AddHabitPage({super.key});

  @override
  ConsumerState<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends ConsumerState<AddHabitPage> {
  // your local state variables go here
  final _nameController = TextEditingController();
  String _frequency = 'Daily';
  Color _selectedColor = AppColors.accent;
  final _color = [
    AppColors.accent,
    AppColors.green,
    AppColors.red,
    const Color(0xff60A5FA),
    const Color(0xffFBBF24),
    const Color(0xffF472B6),
  ];
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Text(
                    'New habit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Habit Name',
                  labelStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Note',
                  labelStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'FREQUENCY',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: ['Daily', 'Weekdays', 'Weekly'].map((freq) {
                  final isSelected = _frequency == freq;
                  return GestureDetector(
                    onTap: () => setState(() => _frequency = freq),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.accentDark : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: isSelected ? AppColors.accent : AppColors.border),
                      ),
                      child: Text(freq, style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? AppColors.accent : AppColors.textSecondary)),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('COLOR', style: TextStyle(
                  fontSize: 11, color: AppColors.textSecondary, letterSpacing: 0.8)),
              const SizedBox(height: 10),
              Row(
                children: _color.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: isSelected ? Colors.white : Colors.transparent,
                            width: 2),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    if (_nameController.text.isEmpty) return;
                    final habit = Habit(
                      id: DateTime.now().toString(),
                      name: _nameController.text,
                      subtitle: _frequency,
                      color: _selectedColor,
                      progress: 0.0,
                      streak: 0,
                    );
                    ref.read(habitProvider.notifier).addHabit(habit);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('Save habit', style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500,
                          color: AppColors.background)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

