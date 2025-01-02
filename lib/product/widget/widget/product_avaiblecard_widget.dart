import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:caffely/product/widget/widget/minselect_button_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/icon.dart';
import '../../util/base_utility.dart';

class ProductAvaibleCardWidget extends StatelessWidget {
  const ProductAvaibleCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.coffeTypeFirst,
    required this.coffeTypeSecond,
    required this.funcOne,
    required this.funcSecond,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final ProductCoffeAvaibleTypeControl coffeTypeFirst;
  final ProductCoffeAvaibleTypeControl coffeTypeSecond;
  final Function() funcOne;
  final Function() funcSecond;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: BaseUtility.vertical(
        BaseUtility.paddingNormalValue,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Column(
        children: <Widget>[
          // title
          SizedBox(
            width: dynamicViewExtensions.maxWidth(context),
            child: Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingNormalValue,
              ),
              child: TitleMediumBlackBoldText(
                text: AppLocalizations.of(context)!.products_avaible,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          // avaible
          Row(
            children: <Widget>[
              MinSelectButtonWidget(
                func: () => funcOne,
                coffeType: coffeTypeFirst,
                icon: AppIcons.hotOutline,
                buttonText: AppLocalizations.of(context)!.products_hot,
              ),
              MinSelectButtonWidget(
                func: () => funcSecond,
                coffeType: coffeTypeSecond,
                icon: AppIcons.icedOutline,
                buttonText: AppLocalizations.of(context)!.products_ice,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
