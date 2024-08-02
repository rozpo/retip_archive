import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'app/pages/home/home_page.dart';
import 'core/l10n/retip_l10n.dart';

void main() {
  runApp(const RetipApp());
}

class RetipApp extends StatelessWidget {
  const RetipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorSchemeSeed: Colors.lightBlue,
        brightness: Brightness.light,
        fontFamily: 'Play',
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.yellow,
        brightness: Brightness.dark,
        fontFamily: 'Play',
      ),
      home: HomePage(audioPlayer: AudioPlayer()),
      localizationsDelegates: RetipL10n.localizationsDelegates,
      supportedLocales: RetipL10n.supportedLocales,
    );
  }
}
