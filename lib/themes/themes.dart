import 'package:flutter/material.dart';

class Themes {
  Themes._();

  static final ThemeData baseTheme = ThemeData.light();

  static AppBarTheme _buildAppBarTheme() {
    return const AppBarTheme(elevation: 0);
  }

  static TextTheme _buildLightTextTheme() {
    return baseTheme.textTheme;
  }

  static ThemeData buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      appBarTheme: _buildAppBarTheme(),
      textTheme: _buildLightTextTheme(),
      // scaffoldBackgroundColor: AppColors.catskillWhite,
      // primaryColor: AppColors.carbonBlack,
      // colorScheme:
      //     ColorScheme.fromSwatch().copyWith(secondary: AppColors.carbonGrey),
    );
  }
}
