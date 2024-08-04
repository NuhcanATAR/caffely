import 'package:caffely/feature/bottom_menu/bottommenu_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';

class BottomMenuView extends StatefulWidget {
  const BottomMenuView({super.key});

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
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              icon: AppIcons.homeOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              label: '',
            ),
            // search
            NavigationDestination(
              selectedIcon: AppIcons.shopFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              icon: AppIcons.shopOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              label: '',
            ),
            // home
            NavigationDestination(
              selectedIcon: AppIcons.orderFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              icon: AppIcons.orderOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              label: '',
            ),
            // calendar
            NavigationDestination(
              selectedIcon: AppIcons.favoriteFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              icon: AppIcons.favoriteOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              label: '',
            ),
            // profile
            NavigationDestination(
              selectedIcon: AppIcons.userFill.toSvgImg(
                Theme.of(context).colorScheme.primary,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
              ),
              icon: AppIcons.userOutline.toSvgImg(
                Theme.of(context).colorScheme.outline,
                IconSizedsUtility.normalSize,
                IconSizedsUtility.normalSize,
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
