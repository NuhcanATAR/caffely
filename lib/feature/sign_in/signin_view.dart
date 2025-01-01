import 'package:caffely/feature/password/password_view.dart';
import 'package:caffely/feature/sign_in/bloc/cubit.dart';
import 'package:caffely/feature/sign_in/bloc/event.dart';
import 'package:caffely/feature/sign_in/bloc/state.dart';
import 'package:caffely/feature/sign_in/signin_viewmodel.dart';
import 'package:caffely/feature/sign_up/signup_view.dart';
import 'package:caffely/lang/app_localizations.dart';
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
            BaseUtility.iconNormalSize,
            BaseUtility.iconNormalSize,
          ),
        ),
      ),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: signInListenerBloc,
        builder: (BuildContext context, blocState) {
          return Form(
            key: formSignInKey,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingNormalValue,
              ),
              child: Column(
                children: <Widget>[
                  // body
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        // title & sub title
                        buildTitleSubTitleWidget,
                        // email & password
                        buildEmailPasswordWidget,
                        // remember me & forgot password
                        buildRememberMeForgotPasswordWidget,
                        // sign up
                        buildSignUpWidget,
                      ],
                    ),
                  ),
                  // sign in
                  buildSignInWidget(blocState),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // title & sub title
  Widget get buildTitleSubTitleWidget => Padding(
        padding: BaseUtility.vertical(
          BaseUtility.paddingNormalValue,
        ),
        child: Column(
          children: <Widget>[
            // title
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.bottom(
                  BaseUtility.paddingNormalValue,
                ),
                child: TitleLargeBlackBoldText(
                  text: AppLocalizations.of(context)!.sign_email_title,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // sub title
            SizedBox(
              width: dynamicViewExtensions.maxWidth(context),
              child: Padding(
                padding: BaseUtility.bottom(
                  BaseUtility.paddingNormalValue,
                ),
                child: BodyMediumBlackText(
                  text: AppLocalizations.of(context)!.sign_email_subtitle,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      );

  // email & password
  Widget get buildEmailPasswordWidget => Column(
        children: <Widget>[
          // email
          CustomEmailFieldWidget(
            emailController: emailController,
            hintText: AppLocalizations.of(context)!.sign_email,
            onChanged: (String value) {
              context.read<SignInBloc>().add(SignInEmailEvent(value));
            },
            isLabelText: true,
          ),
          // password
          CustomPasswordFieldWidget(
            passwordController: passwordController,
            hintText: AppLocalizations.of(context)!.sign_password,
            onChanged: (String value) {
              context.read<SignInBloc>().add(SignInPasswordEvent(value));
            },
            isValidator: false,
            isLabelText: true,
          ),
        ],
      );

  // remember me & forgot password
  Widget get buildRememberMeForgotPasswordWidget => Padding(
        padding: BaseUtility.vertical(
          BaseUtility.paddingNormalValue,
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
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: Padding(
                      padding: BaseUtility.horizontal(
                        BaseUtility.paddingSmallValue,
                      ),
                      child: BodyMediumBlackText(
                        text: AppLocalizations.of(context)!.sign_remember_me,
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
                child: BodyMediumMainColorBoldText(
                  text: AppLocalizations.of(context)!.sign_forgot_password,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      );

  // sign up
  Widget get buildSignUpWidget => Padding(
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
                  text: AppLocalizations.of(context)!.sign_signup_title,
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
                    text: AppLocalizations.of(context)!.sign_signup,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      );

  // sign in
  Widget buildSignInWidget(SignInState blocState) => CustomButtonWidget(
        dynamicViewExtensions: dynamicViewExtensions,
        text: AppLocalizations.of(context)!.sign_sign_btn,
        func: blocState.email.isEmpty || blocState.password.isEmpty
            ? () {}
            : () {
                if (formSignInKey.currentState!.validate()) {
                  context.read<SignInBloc>().add(
                        SignInUserEvent(
                          blocState.email,
                          blocState.password,
                          dynamicViewExtensions,
                          context,
                        ),
                      );
                  emailController.clear();
                  passwordController.clear();
                }
              },
        btnStatus: blocState.email.isEmpty || blocState.password.isEmpty
            ? ButtonTypes.borderPrimaryColorButton
            : ButtonTypes.primaryColorButton,
      );
}
