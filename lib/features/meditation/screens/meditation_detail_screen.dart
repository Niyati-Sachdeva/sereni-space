import 'package:flutter/material.dart';
import '../models/meditation_session.dart';
import 'meditation_timer_screen.dart';

class MeditationDetailScreen extends StatelessWidget {
  final MeditationSession session;

  const MeditationDetailScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(session.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              session.icon,
              size: 72,
              color: session.accentColor,
            ),

            const SizedBox(height: 20),

            Text(
              session.title,
              style: theme.textTheme.headlineMedium,
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                session.duration,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'About this session',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              session.description,
              style: theme.textTheme.bodyLarge,
            ),

            const SizedBox(height: 30),

            Text(
              'Instructions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              '• Sit comfortably\n'
              '• Close your eyes\n'
              '• Focus on your breathing\n'
              '• If your mind wanders, gently return your attention',
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
              onPressed: () {
  final minutes = int.parse(
    session.duration.split(' ').first,
  );

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MeditationTimerScreen(
        durationInMinutes: minutes,
      ),
    ),
  );
},
                child: const Text(
                  'Start Session',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}