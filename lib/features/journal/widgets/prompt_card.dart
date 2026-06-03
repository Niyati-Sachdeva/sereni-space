import 'package:flutter/material.dart';
import '../journal_prompt_service.dart';

class PromptCard extends StatefulWidget {
  final ValueChanged<String>? onPromptLoaded;

  const PromptCard({
    super.key,
    this.onPromptLoaded,
  });

  @override
  State<PromptCard> createState() => _PromptCardState();
}

class _PromptCardState extends State<PromptCard> {
  String _prompt = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrompt();
  }

  Future<void> _loadPrompt() async {
    setState(() => _isLoading = true);

    final prompt = await fetchJournalPrompt();

    if (!mounted) return;

    setState(() {
      _prompt = prompt;
      _isLoading = false;
    });

    widget.onPromptLoaded?.call(prompt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withOpacity(0.6),
            colorScheme.secondaryContainer.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.15),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '✨',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Today's Prompt",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _isLoading ? null : _loadPrompt,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.refresh_rounded,
                    size: 16,
                    color: colorScheme.primary.withOpacity(
                      _isLoading ? 0.3 : 0.7,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (_isLoading)
            _LoadingShimmer(color: colorScheme.primary)
          else
            Text(
              _prompt,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.85),
                height: 1.55,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

class _LoadingShimmer extends StatefulWidget {
  final Color color;

  const _LoadingShimmer({
    required this.color,
  });

  @override
  State<_LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<_LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _fade = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _shimmerBar({
    required double width,
    required double opacity,
  }) {
    return Container(
      height: 14,
      width: width,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(opacity),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fade,
      builder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBar(
            width: double.infinity,
            opacity: _fade.value,
          ),
          const SizedBox(height: 8),
          _shimmerBar(
            width: 200,
            opacity: _fade.value * 0.8,
          ),
        ],
      ),
    );
  }
}