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
      style: CustomLightTheme().themeDataSecond.textTheme.titleLarge,
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
      style: CustomLightTheme().themeDataSecond.textTheme.titleLarge,
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
      style: CustomLightTheme().themeDataSecond.textTheme.titleLarge!.copyWith(
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
      style: CustomLightTheme().themeDataSecond.textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
