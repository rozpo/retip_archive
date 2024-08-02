import 'package:flutter/material.dart';

mixin RetipTheme {
  static const _fontFamily = 'Play';

  static final light = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
    fontFamily: _fontFamily,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepOrange,
    fontFamily: _fontFamily,
  );
}
