import 'package:flutter/material.dart';
import '../widgets/mood_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedMood;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _GreetingSection(theme: theme),

              const SizedBox(height: 28),

              Text(
                'How are you feeling today?',
                style: theme.textTheme.titleMedium
                    ?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              MoodSelector(
                selectedMood: _selectedMood,
                onMoodSelected: (mood) {
                  setState(() {
                    _selectedMood = mood;
                  });
                },
              ),

              const SizedBox(height: 28),

              _QuoteCard(theme: theme),

              const SizedBox(height: 28),

              Text(
                'Quick actions',
                style: theme.textTheme.titleMedium
                    ?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              _QuickActions(theme: theme),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  const _GreetingSection({
    required this.theme,
  });

  final ThemeData theme;

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning 🌸';
    }

    if (hour < 17) {
      return 'Good Afternoon ☀️';
    }

    return 'Good Evening 🌿';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          _getGreeting(),
          style: theme.textTheme.headlineSmall
              ?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Take a breath. This is your calm space.',
          style: theme.textTheme.bodyMedium
              ?.copyWith(
            color: theme.colorScheme.onSurface
                .withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            '"',
            style: theme.textTheme.displaySmall
                ?.copyWith(
              color: theme.colorScheme.primary,
              height: 0.5,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Peace comes from within. Do not seek it without.',
            style: theme.textTheme.bodyLarge
                ?.copyWith(
              fontStyle: FontStyle.italic,
              color: theme.colorScheme
                  .onPrimaryContainer,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '— Buddha',
            style: theme.textTheme.bodySmall
                ?.copyWith(
              color: theme.colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final actions = [
      (
        icon: Icons.book_outlined,
        label: 'Journal',
      ),
      (
        icon: Icons.self_improvement,
        label: 'Meditate',
      ),
      (
        icon: Icons.air,
        label: 'Breathe',
      ),
      (
        icon: Icons.nightlight_outlined,
        label: 'Sleep',
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.6,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      children: actions.map((action) {
        return InkWell(
          onTap: () {},
          borderRadius:
              BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius:
                  BorderRadius.circular(14),
              border: Border.all(
                color:
                    theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            padding:
                const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(
                  action.icon,
                  color:
                      theme.colorScheme.primary,
                  size: 22,
                ),

                const SizedBox(width: 10),

                Text(
                  action.label,
                  style: theme
                      .textTheme.bodyMedium
                      ?.copyWith(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}