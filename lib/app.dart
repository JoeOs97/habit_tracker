import 'package:flutter/material.dart';
import 'package:portfolio/features/habits/presentation/pages/main_shell.dart';

import 'core/theme/app_theme.dart';
import 'features/habits/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: AppTheme.darkTheme,
      home: const MainShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}