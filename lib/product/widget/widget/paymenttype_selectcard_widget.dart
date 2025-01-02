import 'package:caffely/feature/basket/view/order_complete/ordercomplete_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:flutter/material.dart';

import '../text_widget/body_medium_text.dart';

class PaymentTypeSelectCardWidget extends StatelessWidget {
  const PaymentTypeSelectCardWidget({
    super.key,
    required this.dynamicViewExtensions,
    required this.onChangedOne,
    required this.onChangedSecond,
    required this.groupValueOne,
    required this.groupValueSecond,
  });

  final DynamicViewExtensions dynamicViewExtensions;
  final Function(PaymentType?)? onChangedOne;
  final Function(PaymentType?)? onChangedSecond;
  final PaymentType? groupValueOne;
  final PaymentType? groupValueSecond;

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
          borderRadius: const BorderRadius.all(
            Radius.circular(
              BaseUtility.radiusNormalValue,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            // title
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.vertical(
                  BaseUtility.paddingMediumValue,
                ),
                child: BodyMediumBlackBoldText(
                  text: AppLocalizations.of(context)!.payment_type_select_title,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // payment select
            Padding(
              padding: BaseUtility.vertical(
                BaseUtility.paddingMediumValue,
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Radio<PaymentType>(
                          value: PaymentType.online,
                          groupValue: groupValueOne,
                          onChanged: onChangedOne,
                        ),
                        BodyMediumBlackBoldText(
                          text: AppLocalizations.of(context)!
                              .payment_type_online_payment,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Radio<PaymentType>(
                          value: PaymentType.payAtTheDoor,
                          groupValue: groupValueSecond,
                          onChanged: onChangedSecond,
                        ),
                        BodyMediumBlackBoldText(
                          text: AppLocalizations.of(context)!
                              .payment_type_atthe_door,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
