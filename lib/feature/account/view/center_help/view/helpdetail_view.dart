import 'package:caffely/feature/account/view/center_help/view/helpdetail_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/model/centerhelp_model/centerhelp_model.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';

class HelpdetailView extends StatefulWidget {
  const HelpdetailView({
    super.key,
    required this.helpModel,
  });

  final CenterHelpModel helpModel;

  @override
  State<HelpdetailView> createState() => _HelpdetailViewState();
}

class _HelpdetailViewState extends HelpDetailViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: AppIcons.arrowLeft.toSvgImg(
            Colors.black,
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
        title: BodyMediumBlackText(
          text: widget.helpModel.title,
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: BaseUtility.all(
          BaseUtility.paddingNormalValue,
        ),
        child: Column(
          children: <Widget>[
            // body
            buildBodyWidget,
            // footer
            buildFooterWidget,
          ],
        ),
      ),
    );
  }

  // body
  Expanded get buildBodyWidget => Expanded(
        child: ListView(
          children: <Widget>[
            // explanation
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: BodyMediumBlackText(
                text: widget.helpModel.explanation,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );

  // footer
  CustomButtonWidget get buildFooterWidget => CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: AppLocalizations.of(context)!.account_centerhelp_footer_btn,
        func: whatsAppOpen,
        btnStatus: ButtonTypes.primaryColorButton,
      );
}
