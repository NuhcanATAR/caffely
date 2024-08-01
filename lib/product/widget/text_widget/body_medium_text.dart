import 'package:flutter/material.dart';

import '../../theme/light_theme.dart';

class BodyMediumBlackBoldText extends StatelessWidget {
  const BodyMediumBlackBoldText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito Bold',
          ),
    );
  }
}

class BodyMediumBlackText extends StatelessWidget {
  const BodyMediumBlackText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium,
    );
  }
}

class BodyMediumWhiteBoldText extends StatelessWidget {
  const BodyMediumWhiteBoldText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Nunito Bold',
            color: Colors.white,
          ),
    );
  }
}

class BodyMediumBlueBoldText extends StatelessWidget {
  const BodyMediumBlueBoldText({
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
          .themeData
          .textTheme
          .bodyMedium!
          .copyWith(fontWeight: FontWeight.bold, color: Colors.lightBlue),
    );
  }
}

class BodyMediumMainColorText extends StatelessWidget {
  const BodyMediumMainColorText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}

class BodyMediumMainColorBoldText extends StatelessWidget {
  const BodyMediumMainColorBoldText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class BodyMediumRedText extends StatelessWidget {
  const BodyMediumRedText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
    );
  }
}

class BodyMediumRedBoldText extends StatelessWidget {
  const BodyMediumRedBoldText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class BodyMediumWhiteText extends StatelessWidget {
  const BodyMediumWhiteText({
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
      style: CustomLightTheme().themeData.textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
