import 'package:caffely/feature/password/password_view.dart';
import 'package:caffely/feature/sign_in/bloc/cubit.dart';
import 'package:caffely/feature/sign_in/bloc/event.dart';
import 'package:caffely/feature/sign_in/bloc/state.dart';
import 'package:caffely/feature/sign_in/signin_viewmodel.dart';
import 'package:caffely/feature/sign_up/signup_view.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/emailfield_widget.dart';
import 'package:caffely/product/widget/widget/passwordfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends SignInViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
      ),
      body: BlocBuilder<SignInBloc, SignInState>(
        builder: (BuildContext context, state) {
          return BlocConsumer<SignInBloc, SignInState>(
            listener: signInListenerBloc,
            builder: (BuildContext context, blocState) {
              return Form(
                key: formSignInKey,
                child: Padding(
                  padding: PaddingSizedsUtility.all(
                    PaddingSizedsUtility.normalPaddingValue,
                  ),
                  child: Column(
                    children: <Widget>[
                      // body
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            // title & sub title
                            Padding(
                              padding: PaddingSizedsUtility.vertical(
                                PaddingSizedsUtility.normalPaddingValue,
                              ),
                              child: Column(
                                children: <Widget>[
                                  // title
                                  SizedBox(
                                    width:
                                        dynamicViewExtensions.maxWidth(context),
                                    child: Padding(
                                      padding: PaddingSizedsUtility.bottom(
                                        PaddingSizedsUtility.normalPaddingValue,
                                      ),
                                      child: const TitleLargeBlackBoldText(
                                        text: 'Giriş Yap 👩‍💻',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  // sub title
                                  SizedBox(
                                    width:
                                        dynamicViewExtensions.maxWidth(context),
                                    child: Padding(
                                      padding: PaddingSizedsUtility.bottom(
                                        PaddingSizedsUtility.normalPaddingValue,
                                      ),
                                      child: const BodyMediumBlackText(
                                        text:
                                            "Hesap bilgilerinizi girin ve Caffely'e giriş yapın",
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // email
                            CustomEmailFieldWidget(
                              emailController: emailController,
                              hintText: 'E-mail',
                              onChanged: (String value) {
                                context
                                    .read<SignInBloc>()
                                    .add(SignInEmailEvent(value));
                              },
                              isLabelText: true,
                            ),
                            // password
                            CustomPasswordFieldWidget(
                              passwordController: passwordController,
                              hintText: 'Şifre',
                              onChanged: (String value) {
                                context
                                    .read<SignInBloc>()
                                    .add(SignInPasswordEvent(value));
                              },
                              isValidator: false,
                              isLabelText: true,
                            ),
                            // remember me & forgot password
                            Padding(
                              padding: PaddingSizedsUtility.vertical(
                                PaddingSizedsUtility.normalPaddingValue,
                              ),
                              child: Row(
                                children: <Widget>[
                                  // remember me
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: isRememberMe,
                                          onChanged: rememberMeOnChanged,
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                PaddingSizedsUtility.horizontal(
                                              PaddingSizedsUtility
                                                  .smallPaddingValue,
                                            ),
                                            child: const BodyMediumBlackText(
                                              text: 'Beni Hatırla',
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // forgot password
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        CodeNoahNavigatorRouter.push(
                                          context,
                                          const PasswordView(),
                                          direction: SlideDirection.rightToLeft,
                                        );
                                      },
                                      child: const BodyMediumMainColorBoldText(
                                        text: 'Şifremi Unuttum',
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                        padding:
                                            PaddingSizedsUtility.horizontal(
                                          PaddingSizedsUtility
                                              .smallPaddingValue,
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
                      // sign in
                      CustomButtonWidget(
                        dynamicViewExtensions: dynamicViewExtensions,
                        text: 'Giriş Yap',
                        func: state.email.isEmpty || state.password.isEmpty
                            ? () {}
                            : () {
                                if (formSignInKey.currentState!.validate()) {
                                  context.read<SignInBloc>().add(
                                        SignInUserEvent(
                                          state.email,
                                          state.password,
                                          dynamicViewExtensions,
                                        ),
                                      );
                                  emailController.clear();
                                  passwordController.clear();
                                }
                              },
                        btnStatus: state.email.isEmpty || state.password.isEmpty
                            ? ButtonTypes.borderPrimaryColorButton
                            : ButtonTypes.primaryColorButton,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
