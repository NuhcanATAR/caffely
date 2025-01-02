import 'package:caffely/feature/sign/sign_viewmodel.dart';
import 'package:caffely/feature/sign_in/bloc/cubit.dart';
import 'package:caffely/feature/sign_in/bloc/event.dart';
import 'package:caffely/feature/sign_in/bloc/state.dart';
import 'package:caffely/feature/sign_in/sign_in_view.dart';
import 'package:caffely/feature/sign_up/sign_up_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/constants/logo.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/sign_in_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: signInGoogleListenerBloc,
        builder: (BuildContext context, state) {
          return Padding(
            padding: BaseUtility.all(
              BaseUtility.paddingNormalValue,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // logo
                  Padding(
                    padding: BaseUtility.horizontal(
                      BaseUtility.paddingHugeValue,
                    ),
                    child: AppLogoConstants
                        .appLogoTextNoBackgroundColorPrimary.toImg,
                  ),
                  // title
                  Padding(
                    padding: BaseUtility.vertical(
                      BaseUtility.paddingNormalValue,
                    ),
                    child: TitleLargeBlackBoldText(
                      text: AppLocalizations.of(context)!.sign_title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // google sign in
                  SignInButtonWidget(
                    func: () {
                      context.read<SignInBloc>().add(
                            SignInUserGoogleEvent(
                              dynamicViewExtensions,
                              context,
                            ),
                          );
                    },
                    appIcons: AppIcons.google,
                    buttonText:
                        AppLocalizations.of(context)!.sign_google_sign_btn,
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
                    buttonText:
                        AppLocalizations.of(context)!.sign_email_sign_btn,
                  ),
                  // sign up
                  Padding(
                    padding: BaseUtility.top(
                      BaseUtility.paddingHightValue,
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
                            padding: BaseUtility.horizontal(
                              BaseUtility.paddingSmallValue,
                            ),
                            child: BodyMediumBlackText(
                              text: AppLocalizations.of(context)!
                                  .sign_signup_title,
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
                              padding: BaseUtility.horizontal(
                                BaseUtility.paddingSmallValue,
                              ),
                              child: BodyMediumMainColorText(
                                text: AppLocalizations.of(context)!
                                    .sign_signup_btn,
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
          );
        },
      ),
    );
  }
}
