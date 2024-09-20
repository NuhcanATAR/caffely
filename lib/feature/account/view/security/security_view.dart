import 'package:caffely/feature/account/view/security/security_viewmodel.dart';
import 'package:caffely/feature/password/password_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/widget/menu_card.dart';
import 'package:flutter/material.dart';

class SecurityView extends StatefulWidget {
  const SecurityView({super.key});

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends SecurityViewModel {
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
          text: 'Güvenlik Ayarları',
          textAlign: TextAlign.left,
        ),
      ),
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: ListView(
          children: <Widget>[
            // password
            CustomMenuCardWidget(
              func: () {
                CodeNoahNavigatorRouter.push(
                  context,
                  const PasswordView(),
                );
              },
              dynamicViewExtensions: dynamicViewExtensions,
              menuText: 'Şifremi Unuttum',
              menuIcon: AppIcons.securityOutline,
            ),
          ],
        ),
      ),
    );
  }
}
