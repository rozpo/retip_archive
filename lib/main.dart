import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String asset =
      'assets/${kDebugMode ? 'debug' : 'release'}/images/logo.svg';

  final String text =
      "If you think that in the era of streaming, the art of offline listening to music has not disappeared. It's a sure sign that you need a RETIP!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retip Music Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: SvgPicture.asset(asset),
            ),
            const SizedBox(height: 32),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
