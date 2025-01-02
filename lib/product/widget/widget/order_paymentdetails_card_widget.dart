import 'package:caffely/feature/orders/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/orderbasket_control.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_medium_text.dart';
import 'package:flutter/material.dart';

import '../../core/base/helper/price_convert.dart';

class OrderpaymentDetailsCardWidget extends StatelessWidget {
  const OrderpaymentDetailsCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.state,
    required this.orderModel,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final OrderLoaded state;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dynamicViewExtensions.maxWidth(context),
      child: Container(
        margin: BaseUtility.top(
          BaseUtility.marginNormalValue,
        ),
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
        child: Column(
          children: <Widget>[
            // title
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Container(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                ),
                child: TitleMediumBlackBoldText(
                  text: AppLocalizations.of(context)!
                      .order_paymentdetail_card_title,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // payment details
            // payment type
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!
                            .order_paymentdetail_card_payment_type,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: BodyMediumBlackBoldText(
                        text: orderModel.paymentType ==
                                OrderPaymentType.online.value
                            ? AppLocalizations.of(context)!
                                .order_paymentdetail_card_online_payment
                            : AppLocalizations.of(context)!
                                .order_paymentdetail_card_atthe_door,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // total price
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!
                            .order_paymentdetail_card_total_price,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: BodyMediumBlackBoldText(
                        text:
                            '${CodeNoahPriceConvert.formatPrice(state.totalPrice)}₺',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // quanity
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!
                            .order_paymentdetail_card_quanity,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: BodyMediumBlackBoldText(
                        text: '${state.totalQuanity}x',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // service free
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!
                            .order_paymentdetail_card_service_price,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: BodyMediumBlackBoldText(
                        text: '0₺',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // delivery free
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!
                            .order_paymentdetail_card_delivery_price,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: BodyMediumBlackBoldText(
                        text: '0₺',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // totalp paymet
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingNormalValue,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!
                            .order_paymentdetail_card_total_pay,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: BodyMediumBlackBoldText(
                        text:
                            '${CodeNoahPriceConvert.formatPrice(state.totalPrice)}₺',
                        textAlign: TextAlign.right,
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
