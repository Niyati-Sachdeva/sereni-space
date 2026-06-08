import 'package:flutter/material.dart';

class BreatheScreen extends StatelessWidget {
  const BreatheScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.air,
              size: 100,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(height: 24),

            Text(
              'Box Breathing',
              style: theme.textTheme.headlineMedium,
            ),

            const SizedBox(height: 12),

            Text(
              'Inhale for 4 seconds\nHold for 4 seconds\nExhale for 4 seconds\nHold for 4 seconds',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}