import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomResponseWidget extends StatelessWidget {
  const CustomResponseWidget({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
  });

  final AppImages img;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BaseUtility.all(
        BaseUtility.paddingNormalValue,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // img
              img.toSvgImg(
                null,
                0,
                160,
              ),
              // title
              Padding(
                padding: BaseUtility.top(
                  BaseUtility.paddingHightValue,
                ),
                child: TitleLargeBlackBoldText(
                  text: title,
                  textAlign: TextAlign.center,
                ),
              ),
              // sub title
              Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                child: BodyMediumBlackText(
                  text: subTitle,
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

class CustomLoadingResponseWidget extends StatelessWidget {
  const CustomLoadingResponseWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BaseUtility.all(
        BaseUtility.paddingNormalValue,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // loading
            LoadingAnimationWidget.hexagonDots(
              color: Theme.of(context).colorScheme.primary,
              size: BaseUtility.iconLargeSize,
            ),
            // title
            Padding(
              padding: BaseUtility.top(
                BaseUtility.paddingHightValue,
              ),
              child: BodyMediumBlackBoldText(
                text: title,
                textAlign: TextAlign.center,
              ),
            ),
            // sub title
            Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingSmallValue,
              ),
              child: BodyMediumBlackText(
                text: subTitle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
