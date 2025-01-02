import 'package:caffely/feature/account/view/qr_code/qr_code_view.dart';
import 'package:caffely/lang/app_localizations.dart';
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
            buildLoadingWidget,
            // title & subtitle
            buildTitleSubTitleWidget,
          ],
        ),
      ),
    );
  }

  // loading
  Widget get buildLoadingWidget => Padding(
        padding: BaseUtility.vertical(
          BaseUtility.paddingNormalValue,
        ),
        child: LoadingAnimationWidget.hexagonDots(
          color: Theme.of(context).colorScheme.primary,
          size: BaseUtility.iconLargeSize,
        ),
      );

  // title &  subtitle
  Widget get buildTitleSubTitleWidget => Column(
        children: <Widget>[
          // titles
          Padding(
            padding: BaseUtility.vertical(
              BaseUtility.paddingSmallValue,
            ),
            child: BodyMediumBlackBoldText(
              text: AppLocalizations.of(context)!
                  .account_qrcode_create_loading_title,
              textAlign: TextAlign.center,
            ),
          ),
          // sub title
          Padding(
            padding: BaseUtility.vertical(
              BaseUtility.paddingSmallValue,
            ),
            child: BodyMediumBlackText(
              text: AppLocalizations.of(context)!
                  .account_qrcode_create_loading_subtitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
