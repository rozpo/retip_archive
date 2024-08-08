import 'package:flutter/material.dart';
import 'package:retip/app/pages/home/home_page.dart';
import 'package:retip/app/pages/intro/intro_page.dart';
import 'package:retip/app/pages/settings/settings_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/theme/retip_theme.dart';

enum RetipRoute {
  home,
  settings,
}

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: RetipTheme.light,
      darkTheme: RetipTheme.dark,
      localizationsDelegates: RetipL10n.localizationsDelegates,
      supportedLocales: RetipL10n.supportedLocales,
      initialRoute: 'home',
      onGenerateRoute: (settings) {
        final Widget page;

        if (settings.name == RetipRoute.home.name) {
          page = const HomePage();
        } else if (settings.name == RetipRoute.settings.name) {
          page = const SettingsPage();
        } else {
          throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      },
    );
  }
}
