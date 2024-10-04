import 'package:caffely/feature/basket/view/order_success/ordersuccess_viewmodel.dart';
import 'package:caffely/feature/bottom_menu/bottommenu_view.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';

class OrderSuccessView extends StatefulWidget {
  const OrderSuccessView({super.key});

  @override
  State<OrderSuccessView> createState() => _OrderSuccessViewState();
}

class _OrderSuccessViewState extends OrderSuccessViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const BodyMediumBlackText(
          text: 'Siparişiniz Alındı',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: buildBodyWidget,
      ),
    );
  }

  Center get buildBodyWidget => Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // icon
            Padding(
              padding: PaddingSizedsUtility.bottom(
                PaddingSizedsUtility.normalPaddingValue,
              ),
              child: AppImages.thankYou.toSvgImg(
                null,
                dynamicViewExtensions.maxWidth(context),
                dynamicViewExtensions.dynamicHeight(context, 0.25),
              ),
            ),
            // title
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.mediumPaddingValue,
              ),
              child: const TitleLargeBlackBoldText(
                text: 'Siparişiniz için Teşekkür Ederiz',
                textAlign: TextAlign.center,
              ),
            ),
            // sub title
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.mediumPaddingValue,
              ),
              child: const BodyMediumBlackText(
                text:
                    'Siparişiniz size ulaştırılmak üzere hazırlanıyor profilinizde siparişler bölümünden siparişinizi takip edebilirsiniz.',
                textAlign: TextAlign.center,
              ),
            ),
            // button
            CustomButtonWidget(
              dynamicViewExtensions: dynamicViewExtensions,
              text: 'Devam Et',
              func: () {
                CodeNoahNavigatorRouter.pushAndRemoveUntil(
                  context,
                  const BottomMenuView(),
                );
              },
              btnStatus: ButtonTypes.primaryColorButton,
            ),
          ],
        ),
      );
}
