import 'package:flutter/material.dart';

class JournalInput extends StatelessWidget {
  final TextEditingController controller;

  const JournalInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: value.text.isNotEmpty
                  ? colorScheme.primary.withOpacity(0.4)
                  : colorScheme.outline.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: controller,
                maxLines: 7,
                minLines: 5,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.6,
                ),
                decoration: InputDecoration(
                  hintText:
                      'Write your thoughts here... 🌿\n\nThere\'s no right or wrong way.',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.35),
                    height: 1.6,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 14,
                  bottom: 10,
                ),
                child: Text(
                  '${value.text.length} chars',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}