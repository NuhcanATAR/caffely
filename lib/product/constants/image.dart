// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppImages {
  onBoardingOne('slide_one'),
  onBoardingTwo('slide_second'),
  onBoardingThree('slide_three'),
  notFound('not_found_second'),
  notFoundSecond('not_found'),
  error('error'),
  campaign('campaign'),
  flagTurkey('turkey'),
  flagEnglish('english'),
  permissionWarning('permissionWarning'),
  qrCodeNotFound('qrcode_notfound');

  final String value;
  const AppImages(this.value);

  String get toSvg => "assets/images/$value.svg";
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

  String get toPng => "assets/images/$value.png";
  Image toPngImg(
    double width,
    double height,
  ) =>
      Image.asset(
        toPng,
        width: width,
        height: height,
      );
}
