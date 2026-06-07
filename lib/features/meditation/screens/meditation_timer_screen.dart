import 'dart:async';

import 'package:flutter/material.dart';

class MeditationTimerScreen extends StatefulWidget {
  final int durationInMinutes;

  const MeditationTimerScreen({
    super.key,
    required this.durationInMinutes,
  });

  @override
  State<MeditationTimerScreen> createState() =>
      _MeditationTimerScreenState();
}

class _MeditationTimerScreenState
    extends State<MeditationTimerScreen> {
  Timer? _timer;

  late int _remainingSeconds;

  bool _isRunning = false;

  @override
  void initState() {
    super.initState();

    _remainingSeconds =
        widget.durationInMinutes * 60;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingSeconds <= 0) {
          timer.cancel();

          setState(() {
            _isRunning = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Session Complete 🌿',
              ),
            ),
          );

          return;
        }

        setState(() {
          _remainingSeconds--;
        });
      },
    );
  }

  void _pauseTimer() {
    _timer?.cancel();

    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();

    setState(() {
      _remainingSeconds =
          widget.durationInMinutes * 60;

      _isRunning = false;
    });
  }

  String get formattedTime {
    final minutes =
        (_remainingSeconds ~/ 60)
            .toString()
            .padLeft(2, '0');

    final seconds =
        (_remainingSeconds % 60)
            .toString()
            .padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Timer'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme
                      .colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Text(
                    formattedTime,
                    style: theme
                        .textTheme.displayMedium
                        ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning
                        ? null
                        : _startTimer,
                    child: const Text(
                      'Start',
                    ),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton(
                    onPressed: _isRunning
                        ? _pauseTimer
                        : null,
                    child: const Text(
                      'Pause',
                    ),
                  ),

                  const SizedBox(width: 12),

                  ElevatedButton(
                    onPressed: _resetTimer,
                    child: const Text(
                      'Reset',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}