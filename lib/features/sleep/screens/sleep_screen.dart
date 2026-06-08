import 'package:flutter/material.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.nightlight_outlined,
              size: 100,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(height: 24),

            Text(
              'Sleep Preparation 🌙',
              style: theme.textTheme.headlineMedium,
            ),

            const SizedBox(height: 12),

            Text(
              '• Dim the lights\n'
              '• Avoid screens\n'
              '• Take slow breaths\n'
              '• Relax your shoulders',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}