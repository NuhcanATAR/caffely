import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class CustomMenuCardWidget extends StatelessWidget {
  const CustomMenuCardWidget({
    super.key,
    required this.func,
    required this.dynamicViewExtensions,
    required this.menuText,
    required this.menuIcon,
  });

  final Function() func;
  final DynamicViewExtensions dynamicViewExtensions;
  final String menuText;
  final AppIcons menuIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: SizedBox(
        width: dynamicViewExtensions.maxWidth(context),
        child: Padding(
          padding: BaseUtility.vertical(
            BaseUtility.paddingNormalValue,
          ),
          child: Row(
            children: <Widget>[
              menuIcon.toSvgImg(
                Colors.black,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              Expanded(
                child: Padding(
                  padding: BaseUtility.horizontal(
                    BaseUtility.paddingNormalValue,
                  ),
                  child: BodyMediumBlackText(
                    text: menuText,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              AppIcons.arrowRight.toSvgImg(
                Colors.black,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomMenuRowCardWidget extends StatelessWidget {
  const CustomMenuRowCardWidget({
    super.key,
    required this.func,
    required this.dynamicViewExtensions,
    required this.menuText,
    required this.menuIcon,
    required this.children,
    required this.isArrowBtn,
  });

  final Function() func;
  final DynamicViewExtensions dynamicViewExtensions;
  final String menuText;
  final AppIcons menuIcon;
  final List<Widget> children;
  final bool isArrowBtn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: SizedBox(
        width: dynamicViewExtensions.maxWidth(context),
        child: Padding(
          padding: BaseUtility.vertical(
            BaseUtility.paddingNormalValue,
          ),
          child: Row(
            children: <Widget>[
              menuIcon.toSvgImg(
                Colors.black,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              Expanded(
                child: Padding(
                  padding: BaseUtility.horizontal(
                    BaseUtility.paddingNormalValue,
                  ),
                  child: BodyMediumBlackText(
                    text: menuText,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: children,
                ),
              ),
              isArrowBtn == true
                  ? AppIcons.arrowRight.toSvgImg(
                      Colors.black,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
