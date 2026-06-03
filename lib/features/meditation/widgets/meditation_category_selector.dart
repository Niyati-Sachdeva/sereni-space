import 'package:flutter/material.dart';

class MeditationCategorySelector extends StatelessWidget {
  final List<MeditationCategory> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const MeditationCategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.label == selectedCategory;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            child: GestureDetector(
              onTap: () => onCategoryChanged(category.label),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  // Selected: filled with primary; unselected: soft surface
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(50),
                  // Subtle border on unselected to add definition
                  border: isSelected
                      ? null
                      : Border.all(
                          color: colorScheme.outlineVariant,
                          width: 1,
                        ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.28),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category.emoji,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      category.label,
                      style: textTheme.labelMedium?.copyWith(
                        fontFamily: 'Nunito',
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? colorScheme.onPrimary
                            : colorScheme.onSurfaceVariant,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class MeditationCategory {
  final String label;
  final String emoji;

  const MeditationCategory({required this.label, required this.emoji});
}