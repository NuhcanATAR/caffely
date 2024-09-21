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
        margin: MarginSizedsUtility.right(
          MarginSizedsUtility.normalMarginValue,
        ),
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
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
          borderRadius: BorderRadius.all(
            Radius.circular(
              RadiusUtility.circularMediumValue,
            ),
          ),
        ),
        child: Padding(
          padding: PaddingSizedsUtility.horizontal(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.smallPaddingValue,
                ),
                child: icon.toSvgImg(
                  Colors.black,
                  IconSizedsUtility.normalSize,
                  IconSizedsUtility.normalSize,
                ),
              ),
              Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.smallPaddingValue,
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
        margin: MarginSizedsUtility.right(
          MarginSizedsUtility.normalMarginValue,
        ),
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
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
          borderRadius: BorderRadius.all(
            Radius.circular(
              RadiusUtility.circularMediumValue,
            ),
          ),
        ),
        child: Padding(
          padding: PaddingSizedsUtility.horizontal(
            PaddingSizedsUtility.normalPaddingValue,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.smallPaddingValue,
                ),
                child: icon.toSvgImg(
                  Colors.black,
                  IconSizedsUtility.normalSize,
                  IconSizedsUtility.normalSize,
                ),
              ),
              Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.smallPaddingValue,
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
