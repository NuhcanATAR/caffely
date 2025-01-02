// ignore_for_file: deprecated_member_use

import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class MinSelectButtonWidget extends StatelessWidget {
  const MinSelectButtonWidget({
    super.key,
    required this.func,
    required this.coffeType,
    required this.icon,
    required this.buttonText,
  });

  final Function() func;
  final ProductCoffeAvaibleTypeControl coffeType;
  final AppIcons icon;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        margin: BaseUtility.right(
          BaseUtility.marginNormalValue,
        ),
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        decoration: BoxDecoration(
          color: coffeType != ProductCoffeAvaibleTypeControl.notSelect
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: coffeType != ProductCoffeAvaibleTypeControl.notSelect
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            width:
                coffeType != ProductCoffeAvaibleTypeControl.notSelect ? 2 : 0.5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
          ),
        ),
        child: Padding(
          padding: BaseUtility.horizontal(
            BaseUtility.iconNormalSize,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingSmallValue,
                ),
                child: icon.toSvgImg(
                  Colors.black,
                  BaseUtility.iconNormalSize,
                  BaseUtility.iconNormalSize,
                ),
              ),
              Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingSmallValue,
                ),
                child: BodyMediumBlackBoldText(
                  text: buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MinSelectButtonSecondWidget extends StatelessWidget {
  const MinSelectButtonSecondWidget({
    super.key,
    required this.func,
    required this.coffeSize,
    required this.icon,
    required this.buttonText,
  });

  final Function() func;
  final ProductTypeControl coffeSize;
  final AppIcons icon;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        margin: BaseUtility.right(
          BaseUtility.marginNormalValue,
        ),
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        decoration: BoxDecoration(
          color: coffeSize != ProductTypeControl.notSelect
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: coffeSize != ProductTypeControl.notSelect
                ? Theme.of(context).colorScheme.primary
                : Colors.grey,
            width: coffeSize != ProductTypeControl.notSelect ? 2 : 0.5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
          ),
        ),
        child: Padding(
          padding: BaseUtility.horizontal(
            BaseUtility.paddingNormalValue,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingSmallValue,
                ),
                child: icon.toSvgImg(
                  Colors.black,
                  BaseUtility.iconNormalSize,
                  BaseUtility.iconNormalSize,
                ),
              ),
              Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingSmallValue,
                ),
                child: BodyMediumBlackBoldText(
                  text: buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
