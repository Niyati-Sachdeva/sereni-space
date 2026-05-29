import 'package:flutter/material.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    super.key,
    required this.selectedMood,
    required this.onMoodSelected,
  });

  final String? selectedMood;
  final ValueChanged<String> onMoodSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const moods = [
      (emoji: '😊', label: 'Happy'),
      (emoji: '😌', label: 'Calm'),
      (emoji: '😰', label: 'Stressed'),
      (emoji: '😴', label: 'Tired'),
      (emoji: '😔', label: 'Sad'),
    ];

    return SizedBox(
      height: 82,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: moods.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final mood = moods[index];
          final isSelected =
              selectedMood == mood.label;

          return GestureDetector(
            onTap: () =>
                onMoodSelected(mood.label),
            child: AnimatedContainer(
              duration:
                  const Duration(milliseconds: 200),
              width: 64,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.surface,
                borderRadius:
                    BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outlineVariant,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    mood.emoji,
                    style: const TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mood.label,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface
                              .withOpacity(0.7),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}