import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/image.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

mixin NotificationMixin {
  void showSettingsDialog(
    BuildContext context,
    DynamicViewExtensions dynamicViewExtensions,
  ) {
    CodeNoahDialogs(context).showModalBottom(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              RadiusUtility.circularMediumValue,
            ),
            topRight: Radius.circular(
              RadiusUtility.circularMediumValue,
            ),
          ),
        ),
        child: Padding(
          padding:
              PaddingSizedsUtility.all(PaddingSizedsUtility.normalPaddingValue),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // AppBar
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: BodyMediumBlackBoldText(
                          text: AppLocalizations.of(context)!.permission_appbar,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: AppIcons.close.toSvgImg(
                          Theme.of(context).colorScheme.onSurface,
                          IconSizedsUtility.normalSize,
                          IconSizedsUtility.normalSize,
                        ),
                      ),
                    ],
                  ),
                ),
                // img
                AppImages.permissionWarning.toSvgImg(
                  null,
                  320,
                  130,
                ),
                // title
                Padding(
                  padding: PaddingSizedsUtility.top(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: TitleLargeBlackBoldText(
                    text: AppLocalizations.of(context)!.permission_title,
                    textAlign: TextAlign.center,
                  ),
                ),
                // sub title
                Padding(
                  padding: PaddingSizedsUtility.vertical(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: BodyMediumBlackText(
                    text: AppLocalizations.of(context)!.permission_subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                // button
                CustomButtonWidget(
                  dynamicViewExtensions: dynamicViewExtensions,
                  text:
                      AppLocalizations.of(context)!.permission_app_setting_btn,
                  func: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    openAppSettings();
                  },
                  btnStatus: ButtonTypes.primaryColorButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
