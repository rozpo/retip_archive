import 'package:flutter/material.dart';
import 'package:retip/app/pages/intro/intro_page.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/theme/retip_theme.dart';

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: RetipTheme.light,
      darkTheme: RetipTheme.dark,
      home: const IntroPage(),
      localizationsDelegates: RetipL10n.localizationsDelegates,
      supportedLocales: RetipL10n.supportedLocales,
    );
  }
}
