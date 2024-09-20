import 'package:caffely/feature/account/view/accountqr_code/accountqrcode_view.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AccountQrCodeCreateLoadingView extends StatefulWidget {
  const AccountQrCodeCreateLoadingView({super.key});

  @override
  State<AccountQrCodeCreateLoadingView> createState() =>
      _AccountQrCodeCreateLoadingViewState();
}

class _AccountQrCodeCreateLoadingViewState
    extends State<AccountQrCodeCreateLoadingView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      if (!mounted) return;
      CodeNoahNavigatorRouter.push(
        context,
        const AccountQrCodeView(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // loading
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.normalPaddingValue,
              ),
              child: LoadingAnimationWidget.hexagonDots(
                color: Theme.of(context).colorScheme.primary,
                size: IconSizedsUtility.largeSize,
              ),
            ),
            // titles
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.smallPaddingValue,
              ),
              child: const BodyMediumBlackBoldText(
                text: 'Qr Kod Oluşturuluyor',
                textAlign: TextAlign.center,
              ),
            ),
            // sub title
            Padding(
              padding: PaddingSizedsUtility.vertical(
                PaddingSizedsUtility.smallPaddingValue,
              ),
              child: const BodyMediumBlackText(
                text: 'Bu biraz zaman alabilir, lütfen bekleyiniz.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
