import 'package:flutter/material.dart';

class MeditationSession {
  final String title;
  final String duration;
  final String description;
  final IconData icon;
  final String category;
  final Color accentColor;

  const MeditationSession({
    required this.title,
    required this.duration,
    required this.description,
    required this.icon,
    required this.category,
    required this.accentColor,
  });
}