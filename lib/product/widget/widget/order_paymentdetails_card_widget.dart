import 'package:caffely/feature/orders/bloc/state.dart';
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
        margin: MarginSizedsUtility.top(
          MarginSizedsUtility.normalMarginValue,
        ),
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
        child: Column(
          children: <Widget>[
            // title
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Container(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                      width: 0.5,
                    ),
                  ),
                ),
                child: const TitleMediumBlackBoldText(
                  text: 'Ödeme Detayları',
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // payment details
            // payment type
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: BodyMediumBlackText(
                        text: 'Ödeme Tipi',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: BodyMediumBlackBoldText(
                        text: orderModel.paymentType ==
                                OrderPaymentType.online.value
                            ? 'Online Ödeme'
                            : 'Kapıda Ödeme',
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
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: BodyMediumBlackText(
                        text: 'Toplam Fiyat',
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
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: BodyMediumBlackText(
                        text: 'Adet',
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
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: const Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: 'Servis Ücreti',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
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
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: const Row(
                  children: <Widget>[
                    Expanded(
                      child: BodyMediumBlackText(
                        text: 'Teslimat Ücreti',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
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
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: Row(
                  children: <Widget>[
                    const Expanded(
                      child: BodyMediumBlackText(
                        text: 'Toplam Ödeme',
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
