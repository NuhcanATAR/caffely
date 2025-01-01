import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:flutter/material.dart';

import '../../constants/icon.dart';

class OrderAdressCardWidget extends StatelessWidget {
  const OrderAdressCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.orderModel,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dynamicViewExtensions.maxWidth(context),
      child: Container(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(
            BaseUtility.radiusNormalValue,
          ),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: BaseUtility.top(
                BaseUtility.paddingMediumValue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: BaseUtility.right(
                      BaseUtility.marginNormalValue,
                    ),
                    padding: BaseUtility.all(
                      BaseUtility.paddingMediumValue,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.outline.withAlpha(15),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        BaseUtility.radiusCircularHighValue,
                      ),
                    ),
                    child: AppIcons.locationOutline.toSvgImg(
                      Colors.black,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    ),
                  ),
                ],
              ),
            ),
            // adress information
            Expanded(
              child: Padding(
                padding: BaseUtility.horizontal(
                  BaseUtility.paddingMediumValue,
                ),
                child: Column(
                  children: <Widget>[
                    // title
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Padding(
                        padding: BaseUtility.vertical(
                          BaseUtility.paddingSmallValue,
                        ),
                        child: TitleMediumBlackBoldText(
                          text: orderModel.adressTitle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    // explanation
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Padding(
                        padding: BaseUtility.bottom(
                          BaseUtility.paddingMediumValue,
                        ),
                        child: BodyMediumBlackText(
                          text: orderModel.adressDirections,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    // city / district
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Padding(
                        padding: BaseUtility.bottom(
                          BaseUtility.paddingMediumValue,
                        ),
                        child: Row(
                          children: <Widget>[
                            AppIcons.locationFill.toSvgImg(
                              Colors.grey,
                              BaseUtility.iconMediumSize,
                              BaseUtility.iconMediumSize,
                            ),
                            Expanded(
                              child: Padding(
                                padding: BaseUtility.left(
                                  BaseUtility.paddingMediumValue,
                                ),
                                child: BodyMediumBlackText(
                                  text:
                                      '${orderModel.adressCity} / ${orderModel.adressDistrict}',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
