import 'package:flutter/material.dart';
import '../widgets/meditation_category_selector.dart';

class _Session {
  final String title;
  final String duration;
  final String description;
  final IconData icon;
  final String category;
  final Color accentColor;

  const _Session({
    required this.title,
    required this.duration,
    required this.description,
    required this.icon,
    required this.category,
    required this.accentColor,
  });
}

// All seed sessions — filtered by selected category in the build method.
const List<_Session> _allSessions = [
  _Session(
    title: 'Morning Calm',
    duration: '5 min',
    description: 'Start your day with gentle awareness and soft breath.',
    icon: Icons.wb_sunny_rounded,
    category: 'All',
    accentColor: Color(0xFFFFB74D),
  ),
  _Session(
    title: 'Box Breathing',
    duration: '3 min',
    description: 'Equal inhale, hold, exhale, hold — a Navy SEAL staple.',
    icon: Icons.air_rounded,
    category: 'Breathing',
    accentColor: Color(0xFF81D4FA),
  ),
  _Session(
    title: 'Release Tension',
    duration: '7 min',
    description: 'Body scan to melt stress from shoulders to feet.',
    icon: Icons.self_improvement_rounded,
    category: 'Stress Relief',
    accentColor: Color(0xFFCE93D8),
  ),
  _Session(
    title: 'Sleep Wind-Down',
    duration: '10 min',
    description: 'Slow your mind before you close your eyes tonight.',
    icon: Icons.nightlight_round,
    category: 'Sleep',
    accentColor: Color(0xFF90CAF9),
  ),
  _Session(
    title: 'Deep Focus',
    duration: '12 min',
    description: 'Anchor attention gently and return without judgment.',
    icon: Icons.center_focus_strong_rounded,
    category: 'Focus',
    accentColor: Color(0xFFA5D6A7),
  ),
  _Session(
    title: 'Anxiety Reset',
    duration: '4 min',
    description: 'Ground yourself with the 5-4-3-2-1 sensing technique.',
    icon: Icons.favorite_border_rounded,
    category: 'Anxiety',
    accentColor: Color(0xFFEF9A9A),
  ),
  _Session(
    title: 'Calm Breath',
    duration: '3 min',
    description: '4-7-8 breathing to quiet a restless nervous system.',
    icon: Icons.air_rounded,
    category: 'Breathing',
    accentColor: Color(0xFF80DEEA),
  ),
  _Session(
    title: 'Stress Melt',
    duration: '6 min',
    description: 'Progressive muscle relaxation for a calmer body and mind.',
    icon: Icons.spa_rounded,
    category: 'Stress Relief',
    accentColor: Color(0xFFB39DDB),
  ),
];


const List<MeditationCategory> _categories = [
  MeditationCategory(label: 'All', emoji: '✨'),
  MeditationCategory(label: 'Breathing', emoji: '🌬️'),
  MeditationCategory(label: 'Stress Relief', emoji: '🌿'),
  MeditationCategory(label: 'Sleep', emoji: '🌙'),
  MeditationCategory(label: 'Focus', emoji: '🎯'),
  MeditationCategory(label: 'Anxiety', emoji: '💙'),
];

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  
  String _selectedCategory = 'All';

  List<_Session> get _filteredSessions {
    if (_selectedCategory == 'All') return _allSessions;
    return _allSessions
        .where((s) => s.category == _selectedCategory)
        .toList();
  }

  void _onCategoryChanged(String category) {
    setState(() => _selectedCategory = category);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
          
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find Your Calm 🧘',
                      style: textTheme.headlineMedium?.copyWith(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Take a few moments to reconnect with yourself.',
                      style: textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Nunito',
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: _FeaturedCard(colorScheme: colorScheme),
              ),
            ),

            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Text(
                  'Browse by focus',
                  style: textTheme.titleSmall?.copyWith(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: MeditationCategorySelector(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategoryChanged: _onCategoryChanged,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            _filteredSessions.isEmpty
                ? SliverToBoxAdapter(
                    child: _EmptyState(
                      category: _selectedCategory,
                      colorScheme: colorScheme,
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList.separated(
                      itemCount: _filteredSessions.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
    
                        return _SessionCard(
                          session: _filteredSessions[index],
                          colorScheme: colorScheme,
                          textTheme: textTheme,
                        );
                      },
                    ),
                  ),

            // Bottom breathing room
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}


class _FeaturedCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const _FeaturedCard({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withOpacity(0.75),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative soft circle — gives depth without video/animation
          Positioned(
            right: -24,
            top: -24,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.09),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.22),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'Featured · 5 min',
                    style: textTheme.labelSmall?.copyWith(
                      fontFamily: 'Nunito',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Morning Calm',
                  style: textTheme.titleLarge?.copyWith(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ease into your day with gentle awareness.',
                  style: textTheme.bodySmall?.copyWith(
                    fontFamily: 'Nunito',
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                const SizedBox(height: 14),

                // Start button — UI only (V2 will wire up the timer)
                GestureDetector(
                  onTap: () {
                    // V2: navigate to TimerScreen or open bottom sheet with timer
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Timer coming in V2 🌿',
                          style: TextStyle(fontFamily: 'Nunito'),
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.inverseSurface,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: colorScheme.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Begin Session',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class _SessionCard extends StatelessWidget {
  final _Session session;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SessionCard({
    required this.session,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          // V2: open countdown timer bottom sheet
          // V3: start audio playback via MeditationAudioService
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${session.title} — timer in V2 🧘',
                style: const TextStyle(fontFamily: 'Nunito'),
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: colorScheme.inverseSurface,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: session.accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  session.icon,
                  color: session.accentColor,
                  size: 26,
                ),
              ),

              const SizedBox(width: 14),

              // Title + description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.title,
                      style: textTheme.titleSmall?.copyWith(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      session.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        fontFamily: 'Nunito',
                        color: colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Duration badge
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      session.duration,
                      style: textTheme.labelSmall?.copyWith(
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colorScheme.outlineVariant,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }}

class _EmptyState extends StatelessWidget {
  final String category;
  final ColorScheme colorScheme;

  const _EmptyState({required this.category, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.self_improvement_rounded,
              size: 36,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Nothing here yet 🌿',
            style: textTheme.titleMedium?.copyWith(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'More $category sessions are on their way.\nCheck back soon.',
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              fontFamily: 'Nunito',
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}