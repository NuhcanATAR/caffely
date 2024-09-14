import 'package:caffely/feature/account/view/accountqr_code/accountqrcode_viewmodel.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class AccountQrCodeView extends StatefulWidget {
  const AccountQrCodeView({super.key});

  @override
  State<AccountQrCodeView> createState() => _AccountQrCodeViewState();
}

class _AccountQrCodeViewState extends AccountQrCodeViewModel {
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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
        title: const BodyMediumBlackText(
          text: 'Caffely Profil QR Kod',
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
