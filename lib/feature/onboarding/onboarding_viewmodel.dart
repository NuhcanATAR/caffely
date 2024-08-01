import 'package:animate_do/animate_do.dart';
import 'package:caffely/feature/onboarding/onboarding_view.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:flutter/material.dart';

import '../../product/core/base/base_state/base_state.dart';
import '../../product/widget/text_widget/body_medium_text.dart';

abstract class OnBoardingViewModel extends BaseState<OnBoardingView> {
  late int selectProccessIndex = 0;

  late List<Widget> onBoardingImage = <Widget>[
    FadeInDown(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.onBoardingOne.toPng),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    FadeInDown(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.onBoardingTwo.toPng),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    FadeInDown(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.onBoardingThree.toPng),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  ];

  late List<Widget> onBoardingText = <Widget>[
    FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // title
          Padding(
            padding: PaddingSizedsUtility.bottom(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: const TitleLargeBlackBoldText(
              text: "Caffely'e Hoşgeldiniz",
              textAlign: TextAlign.center,
            ),
          ),
          // sub title
          Padding(
            padding: PaddingSizedsUtility.bottom(
              PaddingSizedsUtility.smallPaddingValue,
            ),
            child: const BodyMediumBlackText(
              text: 'Caffely ile kahvenizi hızlı bir şekilde sipariş verin.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
    FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // title
          Padding(
            padding: PaddingSizedsUtility.bottom(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: const TitleLargeBlackBoldText(
              text: "Caffely Kullanmaya Başlayın",
              textAlign: TextAlign.center,
            ),
          ),
          // sub title
          Padding(
            padding: PaddingSizedsUtility.bottom(
              PaddingSizedsUtility.smallPaddingValue,
            ),
            child: const BodyMediumBlackText(
              text:
                  'Size en uygun kahveyi istediğiniz şubeden hemen sipariş verin.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
    FadeInUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // title
          Padding(
            padding: PaddingSizedsUtility.bottom(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: const TitleLargeBlackBoldText(
              text: "Kahve Siparişi Artık Daha Kolay",
              textAlign: TextAlign.center,
            ),
          ),
          // sub title
          Padding(
            padding: PaddingSizedsUtility.bottom(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            child: const BodyMediumBlackText(
              text: 'Caffely ile kahve siparişi vermek için hemen giriş yapın.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  ];
}
