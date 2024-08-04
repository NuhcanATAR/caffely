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
            title: const BodyMediumBlackBoldText(
              text: 'Çıkış Yapılıyor',
              textAlign: TextAlign.center,
            ),
            content: const LabelMediumBlackText(
              text: 'Çıkış yapmak istediğinize eminmisiniz.',
              textAlign: TextAlign.center,
            ),
            actionsPadding: PaddingSizedsUtility.all(
              PaddingSizedsUtility.normalPaddingValue,
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
                      child: const Text('Evet'),
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
                      child: const Text('Hayır'),
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
