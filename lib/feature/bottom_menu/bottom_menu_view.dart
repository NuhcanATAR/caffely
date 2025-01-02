import 'package:caffely/feature/bottom_menu/bottom_menu_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/bottom_menu_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';

class BottomMenuView extends StatefulWidget {
  const BottomMenuView({
    super.key,
    this.startView,
  });

  final BottomMenuViews? startView;

  @override
  State<BottomMenuView> createState() => _BottomMenuViewState();
}

class _BottomMenuViewState extends BottomMenuViewModel {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () => exitWarningDialog(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        body: viewList[selectView],
        bottomNavigationBar: NavigationBar(
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
          indicatorColor: Colors.transparent,
          selectedIndex: selectView,
          height: 90,
          onDestinationSelected: menuClickChange,
          destinations: <Widget>[
            // selling buying
            NavigationDestination(
              selectedIcon: AppIcons.homeFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              icon: AppIcons.homeOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              label: '',
            ),
            // search
            NavigationDestination(
              selectedIcon: AppIcons.shopFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              icon: AppIcons.shopOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              label: '',
            ),
            // home
            NavigationDestination(
              selectedIcon: AppIcons.orderFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              icon: AppIcons.orderOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              label: '',
            ),
            // calendar
            NavigationDestination(
              selectedIcon: AppIcons.favoriteFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              icon: AppIcons.favoriteOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              label: '',
            ),
            // profile
            NavigationDestination(
              selectedIcon: AppIcons.userFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              icon: AppIcons.userOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              label: '',
            ),
          ],
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
