import 'package:flutter/material.dart';

import '../../theme/light_theme.dart';

class TitleMediumBlackBoldText extends StatelessWidget {
  const TitleMediumBlackBoldText({
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
      style: CustomLightTheme().themeDataSecond.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class TitleMediumWhiteBoldText extends StatelessWidget {
  const TitleMediumWhiteBoldText({
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
      style: CustomLightTheme().themeDataSecond.textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
    );
  }
}

class TitleMediumBlackText extends StatelessWidget {
  const TitleMediumBlackText({
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
      style: CustomLightTheme().themeData.textTheme.titleMedium!,
    );
  }
}

class TitleMediumWhiteText extends StatelessWidget {
  const TitleMediumWhiteText({
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
      style: CustomLightTheme()
          .themeDataSecond
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.white),
    );
  }
}

class TitleHeaderWhiteText extends StatelessWidget {
  const TitleHeaderWhiteText({
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
      style: CustomLightTheme()
          .themeDataSecond
          .textTheme
          .titleLarge!
          .copyWith(color: Colors.white),
    );
  }
}

class TitleMediumMainColorText extends StatelessWidget {
  const TitleMediumMainColorText({
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
      style: CustomLightTheme().themeDataSecond.textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}
