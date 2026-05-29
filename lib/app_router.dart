import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'features/home/screens/home_screen.dart';
import 'features/journal/screen/journal_screen.dart';
import 'features/meditation/screens/meditation_sceen.dart';
import 'features/settings/screens/settings_screen.dart';
import 'shared/widgets/app_shell.dart';
import 'features/splash/screens/splash_screen.dart';


final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
  path: '/splash',
  builder: (context, state) => const SplashScreen(),
),

    ShellRoute(
      builder: (context, state, child) {
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/journal',
          builder: (context, state) => const JournalScreen(),
        ),
        GoRoute(
          path: '/meditation',
          builder: (context, state) => const MeditationScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);