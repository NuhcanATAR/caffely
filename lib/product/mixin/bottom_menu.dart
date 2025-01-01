import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/label_medium_text.dart';
import 'package:flutter/material.dart';

mixin BottomMenuMixin {
  // exit dialog
  Future<bool> exitWarningDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: BodyMediumBlackBoldText(
              text: AppLocalizations.of(context)!.account_exit_title,
              textAlign: TextAlign.center,
            ),
            content: LabelMediumBlackText(
              text: AppLocalizations.of(context)!.account_exit_subtitle,
              textAlign: TextAlign.center,
            ),
            actionsPadding: BaseUtility.all(
              BaseUtility.paddingNormalValue,
            ),
            actions: [
              Row(
                children: <Widget>[
                  // yes
                  Flexible(
                    fit: FlexFit.tight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green),
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child:
                          Text(AppLocalizations.of(context)!.account_exit_yes),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // no
                  Flexible(
                    fit: FlexFit.tight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child:
                          Text(AppLocalizations.of(context)!.account_exit_no),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;
  }
}
