import 'package:caffely/product/theme/light_theme.dart';
import 'package:flutter/material.dart';

class TitleLargeBlackBoldText extends StatelessWidget {
  const TitleLargeBlackBoldText({
    super.key,
    required this.text,
    required this.textAlign,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: CustomLightTheme().themeData.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito Bold',
          ),
    );
  }
}

class TitleLargeBlackText extends StatelessWidget {
  const TitleLargeBlackText({
    super.key,
    required this.text,
    required this.textAlign,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: CustomLightTheme().themeData.textTheme.titleLarge!.copyWith(
            fontFamily: 'Nunito Bold',
          ),
    );
  }
}

class TitleLargeWhiteBoldText extends StatelessWidget {
  const TitleLargeWhiteBoldText({
    super.key,
    required this.text,
    required this.textAlign,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: CustomLightTheme().themeData.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito Bold',
            color: Colors.white,
          ),
    );
  }
}

class TitleLargeMainColorBoldText extends StatelessWidget {
  const TitleLargeMainColorBoldText({
    super.key,
    required this.text,
    required this.textAlign,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: CustomLightTheme().themeData.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito Bold',
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
