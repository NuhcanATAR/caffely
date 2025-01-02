import 'package:caffely/feature/account/account_view.dart';
import 'package:caffely/feature/bottom_menu/bottom_menu_view.dart';
import 'package:caffely/feature/favorite/favorite_view.dart';
import 'package:caffely/feature/home/home_view.dart';
import 'package:caffely/feature/orders/orders_view.dart';
import 'package:caffely/feature/store/store_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/bottom_menu_control.dart';
import 'package:caffely/product/mixin/bottom_menu.dart';
import 'package:flutter/material.dart';

abstract class BottomMenuViewModel extends BaseState<BottomMenuView>
    with BottomMenuMixin {
  List<Widget> viewList = <Widget>[
    const HomeView(),
    const StoresView(),
    const OrdersView(),
    const FavoriteView(),
    const AccountView(),
  ];

  late int selectView =
      widget.startView?.menuValue == null ? 0 : widget.startView!.menuValue;

  // menu ontap
  void menuClickChange(int viewValue) {
    setState(() {
      selectView = viewValue;
    });
  }
}
