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
        margin: MarginSizedsUtility.top(
          MarginSizedsUtility.normalMarginValue,
        ),
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        decoration: appIcons == AppIcons.google
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    RadiusUtility.circularMediumValue,
                  ),
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 0.5,
                ),
              )
            : BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    RadiusUtility.circularMediumValue,
                  ),
                ),
              ),
        child: Row(
          children: <Widget>[
            // icon
            appIcons.toSvgImg(
              appIcons == AppIcons.google ? null : Colors.white,
              IconSizedsUtility.normalSize,
              IconSizedsUtility.normalSize,
            ),
            // sign in
            Expanded(
              child: Padding(
                padding: PaddingSizedsUtility.horizontal(
                  PaddingSizedsUtility.normalPaddingValue,
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
