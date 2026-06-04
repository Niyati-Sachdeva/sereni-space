
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/theme_provider.dart';

class _ThemeOption {
  final AppThemePreset preset;
  final String label;
  final Color swatch;
  const _ThemeOption(this.preset, this.label, this.swatch);
}

const List<_ThemeOption> _themes = [
  _ThemeOption(
    AppThemePreset.calmBlue,
    'Calm Blue',
    Color(0xFF64B5F6),
  ),
  _ThemeOption(
    AppThemePreset.warmSunset,
    'Warm Sunset',
    Color(0xFFFFB74D),
  ),
  _ThemeOption(
    AppThemePreset.forestGreen,
    'Forest Green',
    Color(0xFF81C784),
  ),
  _ThemeOption(
    AppThemePreset.sleepLavender,
    'Sleep Lavender',
    Color(0xFFB39DDB),
  ),
];

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch() subscribes this widget to ThemeProvider rebuilds.
    // When the user taps a theme, ThemeProvider notifies listeners and
    // Flutter automatically calls build() again — no setState needed.
    final themeProvider = context.watch<ThemeProvider>();
    final colors        = Theme.of(context).colorScheme;
    final text          = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [

            // ── Header ──────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Settings ⚙️',
                        style: text.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        )),
                    const SizedBox(height: 6),
                    Text('Personalize your Sereni experience.',
                        style: text.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        )),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: _SectionLabel(label: 'APPEARANCE')),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 0,
                  color: colors.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Choose a Theme',
                            style: text.titleSmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            )),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _themes.map((t) {
                            final isSelected =
                                themeProvider.currentPreset == t.preset;
                            return _ThemeChip(
                              option: t,
                              isSelected: isSelected,
                              onTap: () =>
                                  themeProvider.setTheme(t.preset),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ── Preferences Section ──────────────────────────────────────────
            const SliverToBoxAdapter(child: _SectionLabel(label: 'PREFERENCES')),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 0,
                  color: colors.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Column(
                    children: [
                      _DisabledTile(
                        icon: Icons.notifications_outlined,
                        label: 'Notifications',
                      ),
                      Divider(height: 1, indent: 60),
                      _DisabledTile(
                        icon: Icons.alarm_outlined,
                        label: 'Daily Reminder',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── About Section ────────────────────────────────────────────────
            const SliverToBoxAdapter(child: _SectionLabel(label: 'ABOUT')),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 0,
                  color: colors.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Column(
                    children: [
                      _AboutTile(
                          icon: Icons.info_outline,
                          label: 'About Sereni Space'),
                      Divider(height: 1, indent: 60),
                      _AboutTile(
                          icon: Icons.privacy_tip_outlined,
                          label: 'Privacy Policy'),
                      Divider(height: 1, indent: 60),
                      _AboutTile(
                          icon: Icons.verified_outlined,
                          label: 'App Version',
                          trailing: 'v1.0.0'),
                    ],
                  ),
                ),
              ),
            ),

            // ── Coming Soon Card ─────────────────────────────────────────────
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: _ComingSoonCard(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}

// ─── Private widgets (used only once → stay in this file) ────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 8),
      child: Text(label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(0.6),
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              )),
    );
  }
}

// ── Individual theme chip ──────────────────────────────────────────────────

class _ThemeChip extends StatelessWidget {
  final _ThemeOption option;
  final bool isSelected;
  final VoidCallback onTap;
  const _ThemeChip(
      {required this.option,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? option.swatch.withOpacity(0.18)
                : colors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? option.swatch : colors.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Color dot
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: option.swatch,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(option.label,
                  style: text.bodySmall?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? option.swatch.withOpacity(0.9)
                        : colors.onSurfaceVariant,
                  )),
              if (isSelected) ...[
                const SizedBox(width: 6),
                Icon(Icons.check_circle_rounded,
                    size: 14, color: option.swatch),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

// ── Disabled preference tile ───────────────────────────────────────────────

class _DisabledTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _DisabledTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    return Opacity(
      opacity: 0.45,
      child: ListTile(
        leading: Icon(icon, color: colors.onSurfaceVariant),
        title: Text(label, style: text.bodyMedium),
        trailing: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: colors.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('Coming Soon',
              style: text.labelSmall?.copyWith(
                color: colors.onSecondaryContainer,
              )),
        ),
      ),
    );
  }
}

// ── About tile ─────────────────────────────────────────────────────────────

class _AboutTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  const _AboutTile(
      {required this.icon, required this.label, this.trailing});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    return ListTile(
      leading: Icon(icon, color: colors.primary),
      title: Text(label, style: text.bodyMedium),
      trailing: trailing != null
          ? Text(trailing!,
              style: text.bodySmall
                  ?.copyWith(color: colors.onSurfaceVariant))
          : Icon(Icons.chevron_right, color: colors.outlineVariant),
    );
  }
}

// ── Coming Soon card ────────────────────────────────────────────────────────

class _ComingSoonCard extends StatelessWidget {
  const _ComingSoonCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text   = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colors.primaryContainer.withOpacity(0.45),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Text('🌿', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'More personalization features\nare coming soon 🌿',
                style: text.bodyMedium?.copyWith(
                  color: colors.onPrimaryContainer,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}