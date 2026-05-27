import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  // Determines which nav item is active from current route
  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/journal'))   return 1;
    if (location.startsWith('/meditation')) return 2;
    if (location.startsWith('/settings'))  return 3;
    return 0; // home
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex(context),
        onDestinationSelected: (index) {
          switch (index) {
            case 0: context.go('/home');       break;
            case 1: context.go('/journal');    break;
            case 2: context.go('/meditation'); break;
            case 3: context.go('/settings');   break;
          }
        },
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        indicatorColor: theme.colorScheme.primary.withOpacity(0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book_rounded),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.self_improvement_outlined),
            selectedIcon: Icon(Icons.self_improvement_rounded),
            label: 'Meditate',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}