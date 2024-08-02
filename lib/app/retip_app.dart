import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retip/core/l10n/retip_l10n.dart';
import 'package:retip/core/theme/retip_theme.dart';

import 'pages/home/home_page.dart';

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: RetipTheme.light,
      darkTheme: RetipTheme.dark,
      home: HomePage(audioPlayer: AudioPlayer()),
      localizationsDelegates: RetipL10n.localizationsDelegates,
      supportedLocales: RetipL10n.supportedLocales,
    );
  }
}
