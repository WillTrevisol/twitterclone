import 'package:flutter/material.dart';

import 'theme.dart';

class AppTheme {
  static ThemeData theme = ThemeData.dark().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: Pallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Pallete.backgroundColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.blueColor,
    ),
  );
}