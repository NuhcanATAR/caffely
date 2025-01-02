import 'package:caffely/feature/orders/view/order_detail/order_detail_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/order_basket_control.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

import '../../util/base_utility.dart';
import '../text_widget/label_medium_text.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.createDate,
    required this.model,
  });

  final String createDate;
  final OrderModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: BaseUtility.vertical(
        BaseUtility.marginMediumValue,
      ),
      padding: BaseUtility.all(
        BaseUtility.paddingMediumValue,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            BaseUtility.radiusLowValue,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          // order date
          Padding(
            padding: BaseUtility.vertical(
              BaseUtility.paddingMediumValue,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: LabelMediumBlackText(
                    text:
                        '${AppLocalizations.of(context)!.order_card_date}: $createDate',
                    textAlign: TextAlign.left,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    CodeNoahNavigatorRouter.push(
                      context,
                      OrderDetailView(
                        orderModel: model,
                      ),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: BaseUtility.horizontal(
                          BaseUtility.paddingMediumValue,
                        ),
                        child: BodyMediumMainColorText(
                          text: AppLocalizations.of(context)!
                              .order_card_detail_btn,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      AppIcons.arrowRight.toSvgImg(
                        Theme.of(context).colorScheme.primary,
                        BaseUtility.iconNormalSize,
                        BaseUtility.iconNormalSize,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // payment type
          Padding(
            padding: BaseUtility.vertical(
              BaseUtility.paddingMediumValue,
            ),
            child: Row(
              children: <Widget>[
                AppIcons.moneyOutline.toSvgImg(
                  Theme.of(context).colorScheme.primary,
                  BaseUtility.iconNormalSize,
                  BaseUtility.iconNormalSize,
                ),
                Expanded(
                  child: Padding(
                    padding: BaseUtility.horizontal(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: LabelMediumBlackText(
                      text: model.paymentType == OrderPaymentType.online.value
                          ? AppLocalizations.of(context)!
                              .order_card_online_payment
                          : AppLocalizations.of(context)!
                              .order_card_payatthe_door,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // short adress
        ],
      ),
    );
  }
}
