// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcons {
  arrowLeft('arrow_left'),
  dateRangeOutline('date_range_outline'),
  google('google'),
  lockFill('lock_fill'),
  mailFill('mail_fill'),
  add('add'),
  rocketOutline('rocket_outline'),
  warningCircle('warning_circle'),
  eyeOutline('eye_outline'),
  eyeCloseOutline('eyeclose_outline'),
  accountSignIn('account_signin'),
  accountPassword('account_password');

  final String value;
  const AppIcons(this.value);

  String get toSvg => "assets/icons/$value.svg";
  SvgPicture toSvgImg(
    Color? color,
    double width,
    double height,
  ) =>
      SvgPicture.asset(
        toSvg,
        color: color,
        width: width,
        height: height,
      );

  String get toPng => "assets/icons/$value.png";
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
