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
  accountPassword('account_password'),
  callOutline('call_outline'),
  arrowDropDown('arrow_drop_down'),
  arrowRight('arrow_right'),
  doneOutline('done_outline'),
  creditCardOutline('creditcard_outline'),
  favoriteFill('favorite_fill'),
  favoriteOutline('favorite_outline'),
  giftOutline('gift_outline'),
  homeFill('home_fill'),
  homeOutline('home_outline'),
  locationFill('location_fill'),
  locationOutline('pin_outline'),
  notificationOutline('notification_outline'),
  orderFill('order_fill'),
  orderOutline('order_outline'),
  settingOutline('setting_outline'),
  shareOutline('share_outline'),
  shopFill('shop_fill'),
  shopOutline('shop_outline'),
  starFill('star_fill'),
  timeOutline('time_outline'),
  userFill('user_fill'),
  userOutline('user_outline'),
  searchOutline('search_outline'),
  filterOutline('filter_outline'),
  closeOutline('close_light'),
  minusLight('minus_light'),
  hotOutline('hot_coffe'),
  icedOutline('ice_coffe'),
  securityOutline('security_outline'),
  worldOutline('world_outline'),
  sunOutline('sun_outline'),
  moonOutline('moon_outline'),
  fileOutline('file_outline'),
  infoOutline('info_outline'),
  logoutOutline('logout_outline'),
  close('close'),
  github('github'),
  linkedin('linkedin'),
  basketOutline('basket_outline'),
  successfull('successfull'),
  checkDone('check_done'),
  boxBold('box_bold'),
  cancelBold('cancel_bold'),
  homeBold('home_bold'),
  motocycle('motocycle'),
  moneyOutline('money_outline');

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
