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
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(
            RadiusUtility.normalRadiusValue,
          ),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: PaddingSizedsUtility.top(
                PaddingSizedsUtility.mediumPaddingValue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: MarginSizedsUtility.right(
                      MarginSizedsUtility.normalMarginValue,
                    ),
                    padding: PaddingSizedsUtility.all(
                      PaddingSizedsUtility.mediumPaddingValue,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.outline.withAlpha(15),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        RadiusUtility.circularHighValue,
                      ),
                    ),
                    child: AppIcons.locationOutline.toSvgImg(
                      Colors.black,
                      IconSizedsUtility.normalSize,
                      IconSizedsUtility.normalSize,
                    ),
                  ),
                ],
              ),
            ),
            // adress information
            Expanded(
              child: Padding(
                padding: PaddingSizedsUtility.horizontal(
                  PaddingSizedsUtility.mediumPaddingValue,
                ),
                child: Column(
                  children: <Widget>[
                    // title
                    SizedBox(
                      width: dynamicViewExtensions.maxWidth(context),
                      child: Padding(
                        padding: PaddingSizedsUtility.vertical(
                          PaddingSizedsUtility.smallPaddingValue,
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
                        padding: PaddingSizedsUtility.bottom(
                          PaddingSizedsUtility.mediumPaddingValue,
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
                        padding: PaddingSizedsUtility.bottom(
                          PaddingSizedsUtility.mediumPaddingValue,
                        ),
                        child: Row(
                          children: <Widget>[
                            AppIcons.locationFill.toSvgImg(
                              Colors.grey,
                              IconSizedsUtility.mediumSize,
                              IconSizedsUtility.mediumSize,
                            ),
                            Expanded(
                              child: Padding(
                                padding: PaddingSizedsUtility.left(
                                  PaddingSizedsUtility.mediumPaddingValue,
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
