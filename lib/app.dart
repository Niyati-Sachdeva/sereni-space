import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'app_router.dart';


class SereniApp extends StatelessWidget {
  const SereniApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          title: 'Sereni Space',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          routerConfig: appRouter,
        );
      },
    );
  }
}