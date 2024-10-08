import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_view.dart';
import 'package:caffely/feature/basket/view/order_complete/ordercomplete_viewmodel.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
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
          borderRadius: BorderRadius.all(
            Radius.circular(
              RadiusUtility.normalRadiusValue,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            // title
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.mediumPaddingValue,
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: BodyMediumBlackBoldText(
                      text: 'Teslimat Adresi',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      CodeNoahNavigatorRouter.push(
                        context,
                        const SavedadressCreateView(),
                      );
                    },
                    child: const BodyMediumMainColorText(
                      text: 'Adres Ekle',
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            // payment select
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.mediumPaddingValue,
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
                        const BodyMediumBlackBoldText(
                          text: 'Online Ödeme',
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
                        const BodyMediumBlackBoldText(
                          text: 'Kapıda Ödeme',
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
