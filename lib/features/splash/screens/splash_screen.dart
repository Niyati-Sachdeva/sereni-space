import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        if (!mounted) return;

        context.go('/home');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'lib/assets/images/splash_screen/sereni_logo.png',

                width: 280,
                height: 280,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 15),

              Text(
                'Sereni Space',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize:38,
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'your calm corner of the day',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.colorScheme.primary.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 52),

              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.primary.withOpacity(0.45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}