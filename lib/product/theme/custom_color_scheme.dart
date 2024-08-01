import 'package:caffely/product/constants/color.dart';
import 'package:flutter/material.dart';

final class CustomColorScheme {
  CustomColorScheme._();

  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColorPalette.primaryColor, // one primary color hex to #00AF66
    surfaceTint: const Color(0xff39693b),
    onPrimary: const Color(0xffffffff),
    primaryContainer: const Color(0xffbaf0b7),
    onPrimaryContainer: const Color(0xff002106),
    secondary: const Color(0xff39693b),
    onSecondary: const Color.fromARGB(155, 82, 99, 80), // card back
    secondaryContainer: const Color(0xffd5e8d0),
    onSecondaryContainer: const Color.fromARGB(94, 159, 199, 150),
    tertiary: const Color(0xff39656b),
    onTertiary: const Color(0xffffffff),
    tertiaryContainer: const Color(0xffbcebf2),
    onTertiaryContainer: const Color(0xff001f23),
    error: const Color(0xffba1a1a),
    onError: const Color(0xffffffff),
    errorContainer: const Color(0xffffdad6),
    onErrorContainer: const Color(0xff410002),
    surface: const Color(0xFFCED4DA), // textformfield
    onSurface: const Color(0xFF343A40),
    surfaceContainerHighest: const Color.fromARGB(255, 253, 253, 253),
    onSurfaceVariant: const Color(0xff424940),
    outline: const Color(0xff72796f), // border line color
    outlineVariant: const Color(0xffc2c9bd),
    shadow: const Color(0xff000000),
    scrim: const Color(0xff000000),
    inverseSurface: const Color(0xff2d322c),
    inversePrimary: const Color.fromARGB(255, 82, 191, 102), // appbar
  );
}
