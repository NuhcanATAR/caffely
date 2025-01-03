import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class SocialMediaButtonWidget extends StatelessWidget {
  const SocialMediaButtonWidget({
    super.key,
    required this.onTap,
    required this.color,
    required this.icon,
    required this.btnText,
  });

  final Function() onTap;
  final Color color;
  final AppIcons icon;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 4,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: BaseUtility.all(
            BaseUtility.paddingNormalValue,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              BaseUtility.radiusCircularMediumValue,
            ),
          ),
          child: Row(
            children: <Widget>[
              icon.toSvgImg(
                Colors.white,
                BaseUtility.iconNormalSize,
                BaseUtility.iconNormalSize,
              ),
              Padding(
                padding: BaseUtility.horizontal(
                  BaseUtility.paddingSmallValue,
                ),
                child: BodyMediumWhiteText(
                  text: btnText,
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
