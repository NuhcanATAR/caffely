import 'package:caffely/product/theme/custom_color_scheme.dart';
import 'package:caffely/product/theme/custom_theme.dart';
import 'package:flutter/material.dart';

final class CustomLightTheme implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        fontFamily: 'Popins Light',
        colorScheme: CustomColorScheme.lightColorScheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        textTheme: textThemeData,
      );

  ThemeData get themeDataSecond => ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito Bold',
        colorScheme: CustomColorScheme.lightColorScheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        textTheme: textThemeData,
      );

  @override
  final FloatingActionButtonThemeData floatingActionButtonThemeData =
      const FloatingActionButtonThemeData();

  @override
  final TextTheme textThemeData = TextTheme(
    titleLarge: TextStyle(
      fontSize: 22,
      color: CustomColorScheme.lightColorScheme.onSurface,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: CustomColorScheme.lightColorScheme.onSurface,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: CustomColorScheme.lightColorScheme.onSurface,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: CustomColorScheme.lightColorScheme.onSurface,
      fontWeight: FontWeight.normal,
    ),
  );
}
