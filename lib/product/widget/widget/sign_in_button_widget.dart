import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({
    super.key,
    required this.func,
    required this.appIcons,
    required this.buttonText,
  });

  final Function() func;
  final AppIcons appIcons;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        margin: BaseUtility.top(
          BaseUtility.marginNormalValue,
        ),
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        decoration: appIcons == AppIcons.google
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    BaseUtility.radiusCircularMediumValue,
                  ),
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 0.5,
                ),
              )
            : BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    BaseUtility.radiusCircularMediumValue,
                  ),
                ),
              ),
        child: Row(
          children: <Widget>[
            // icon
            appIcons.toSvgImg(
              appIcons == AppIcons.google ? null : Colors.white,
              BaseUtility.iconNormalSize,
              BaseUtility.iconNormalSize,
            ),
            // sign in
            Expanded(
              child: Padding(
                padding: BaseUtility.horizontal(
                  BaseUtility.paddingNormalValue,
                ),
                child: appIcons == AppIcons.google
                    ? BodyMediumBlackBoldText(
                        text: buttonText,
                        textAlign: TextAlign.center,
                      )
                    : BodyMediumWhiteBoldText(
                        text: buttonText,
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
