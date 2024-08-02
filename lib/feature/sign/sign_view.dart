import 'package:caffely/feature/sign/sign_viewmodel.dart';
import 'package:caffely/feature/sign_in/signin_view.dart';
import 'package:caffely/feature/sign_up/signup_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/signin_button_widget.dart';
import 'package:flutter/material.dart';

class SignView extends StatefulWidget {
  const SignView({super.key});

  @override
  State<SignView> createState() => _SignViewState();
}

class _SignViewState extends SignViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      body: Padding(
        padding: PaddingSizedsUtility.all(
          PaddingSizedsUtility.normalPaddingValue,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // logo
              Padding(
                padding: PaddingSizedsUtility.horizontal(
                  PaddingSizedsUtility.hugePaddingValue,
                ),
                child:
                    AppLogoConstants.appLogoTextNoBackgroundColorPrimary.toImg,
              ),
              // title
              Padding(
                padding: PaddingSizedsUtility.vertical(
                  PaddingSizedsUtility.normalPaddingValue,
                ),
                child: const TitleLargeBlackBoldText(
                  text: 'Caffely Giriş Yap',
                  textAlign: TextAlign.center,
                ),
              ),
              // google sign in
              SignInButtonWidget(
                func: () {},
                appIcons: AppIcons.google,
                buttonText: 'Google ile giriş yap',
              ),
              // email sign in
              SignInButtonWidget(
                func: () {
                  CodeNoahNavigatorRouter.push(
                    context,
                    const SignInView(),
                    direction: SlideDirection.rightToLeft,
                  );
                },
                appIcons: AppIcons.mailFill,
                buttonText: 'E-mail ile giriş yap',
              ),
              // sign up
              Padding(
                padding: PaddingSizedsUtility.top(
                  PaddingSizedsUtility.hightPaddingValue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: Padding(
                        padding: PaddingSizedsUtility.horizontal(
                          PaddingSizedsUtility.smallPaddingValue,
                        ),
                        child: const BodyMediumBlackText(
                          text: 'Henüz hesabınız yokmu?',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          CodeNoahNavigatorRouter.push(
                            context,
                            const SignUpView(),
                            direction: SlideDirection.rightToLeft,
                          );
                        },
                        child: Padding(
                          padding: PaddingSizedsUtility.horizontal(
                            PaddingSizedsUtility.smallPaddingValue,
                          ),
                          child: const BodyMediumMainColorText(
                            text: 'Hesap Oluştur',
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
