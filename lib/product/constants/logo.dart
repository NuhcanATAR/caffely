// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppLogoConstants {
  appLogoPrimaryColor('logo_one'),
  appLogoNoBackgroundColorPrimary('logo_three'),
  appLogoNoBackgroundColorWhite('logo_second'),
  appLogoTextPrimaryColor('logo_four'),
  appLogoTextNoBackgroundColorPrimary('logo_six'),
  appLogoTextNoBackgroundColorWhite('logo_five');

  final String value;

  const AppLogoConstants(this.value);

  String get toPng => "assets/logo/$value.png";
  Image get toImg => Image.asset(toPng);

  String get toSvg => "assets/logo/$value.svg";
  SvgPicture toSvgImg(
    Color? color,
    double? width,
    double? height,
  ) =>
      SvgPicture.asset(
        toSvg,
        color: color,
        width: width,
        height: height,
      );
}
