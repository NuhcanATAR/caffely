import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/order_basket_control.dart';
import 'package:caffely/product/model/basket_model/basket_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class OrderStatusCardWidget extends StatelessWidget {
  const OrderStatusCardWidget({
    super.key,
    required this.basketModel,
  });

  final BasketModel basketModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BaseUtility.vertical(
        BaseUtility.paddingMediumValue,
      ),
      child: Row(
        children: <Widget>[
          // order received
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingMediumValue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: BaseUtility.all(
                      BaseUtility.paddingMediumValue,
                    ),
                    decoration: BoxDecoration(
                      color: basketModel.basketStatus ==
                              BasketMainStatusControl.orderRejected.value
                          ? Colors.red
                          : basketModel.basketStatus >=
                                  BasketMainStatusControl.orderReceived.value
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(
                        BaseUtility.radiusCircularHighValue,
                      ),
                    ),
                    child: AppIcons.boxBold.toSvgImg(
                      Colors.white,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    ),
                  ),
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingMediumValue,
                    ),
                    child: BodyMediumBlackBoldText(
                      text: AppLocalizations.of(context)!.order_status_card_one,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  height: 3,
                  color: basketModel.basketStatus ==
                          BasketMainStatusControl.orderRejected.value
                      ? Colors.red
                      : basketModel.basketStatus >=
                              BasketMainStatusControl.orderReceived.value
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                ),
              ],
            ),
          ),
          // order in progress
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingMediumValue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: BaseUtility.all(
                      BaseUtility.paddingMediumValue,
                    ),
                    decoration: BoxDecoration(
                      color: basketModel.basketStatus ==
                              BasketMainStatusControl.orderRejected.value
                          ? Colors.red
                          : basketModel.basketStatus >=
                                  BasketMainStatusControl.orderInProgress.value
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(
                        BaseUtility.radiusCircularHighValue,
                      ),
                    ),
                    child: AppIcons.boxBold.toSvgImg(
                      Colors.white,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    ),
                  ),
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingMediumValue,
                    ),
                    child: BodyMediumBlackBoldText(
                      text: AppLocalizations.of(context)!
                          .order_status_card_second,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  height: 3,
                  color: basketModel.basketStatus ==
                          BasketMainStatusControl.orderRejected.value
                      ? Colors.red
                      : basketModel.basketStatus >=
                              BasketMainStatusControl.orderInProgress.value
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                ),
              ],
            ),
          ),
          // order delivered
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingMediumValue,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: BaseUtility.all(
                      BaseUtility.paddingMediumValue,
                    ),
                    decoration: BoxDecoration(
                      color: basketModel.basketStatus ==
                              BasketMainStatusControl.orderRejected.value
                          ? Colors.red
                          : basketModel.basketStatus >=
                                  BasketMainStatusControl.orderDelivered.value
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                      borderRadius: BorderRadius.circular(
                        BaseUtility.radiusCircularHighValue,
                      ),
                    ),
                    child: AppIcons.boxBold.toSvgImg(
                      Colors.white,
                      BaseUtility.iconNormalSize,
                      BaseUtility.iconNormalSize,
                    ),
                  ),
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingMediumValue,
                    ),
                    child: BodyMediumBlackBoldText(
                      text:
                          AppLocalizations.of(context)!.order_status_card_three,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
