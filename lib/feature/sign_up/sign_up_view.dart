import 'package:caffely/feature/agree/agree_view.dart';
import 'package:caffely/feature/sign_in/sign_in_view.dart';
import 'package:caffely/feature/sign_up/bloc/cubit.dart';
import 'package:caffely/feature/sign_up/bloc/event.dart';
import 'package:caffely/feature/sign_up/bloc/state.dart';
import 'package:caffely/feature/sign_up/sign_up_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/theme/light_theme.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/email_field_widget.dart';
import 'package:caffely/product/widget/widget/password_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends SignUpViewModel {
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
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: signUpListenerBloc,
        builder: (BuildContext context, blocState) {
          return Form(
            key: formSignUpKey,
            child: Padding(
              padding: BaseUtility.all(
                BaseUtility.paddingNormalValue,
              ),
              child: ListView(
                children: <Widget>[
                  // title & sub title
                  buildTitleSubTitleWidget,
                  // email & password
                  buildEmailPasswordWidget,
                  // agree
                  buildAgreeWidget,
                  // sign up
                  buildSignUpWidget(blocState),
                  // sign in
                  buildSignInWidget,
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
                  text: AppLocalizations.of(context)!.signup_email_title,
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
                  text: AppLocalizations.of(context)!.signup_email_subtitle,
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
            hintText: AppLocalizations.of(context)!.signup_email,
            onChanged: (String value) =>
                context.read<SignUpBloc>().add(SignUpEmailEvent(value)),
            isLabelText: true,
          ),
          // password
          CustomPasswordFieldWidget(
            passwordController: passwordController,
            hintText: AppLocalizations.of(context)!.signup_password,
            onChanged: (String value) =>
                context.read<SignUpBloc>().add(SignUpPasswordEvent(value)),
            isValidator: true,
            isLabelText: true,
          ),
        ],
      );

  // agree
  Widget get buildAgreeWidget => Padding(
        padding: BaseUtility.top(
          BaseUtility.paddingNormalValue,
        ),
        child: Row(
          children: <Widget>[
            // check box
            Checkbox(
              value: isAgree,
              onChanged: agreeCheckBox,
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            // agree text
            Expanded(
              child: Padding(
                padding: BaseUtility.horizontal(
                  BaseUtility.paddingNormalValue,
                ),
                child: RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.signup_user_agreement,
                    style: CustomLightTheme()
                        .themeData
                        .textTheme
                        .bodyMedium!
                        .copyWith(
                          color: Colors.black,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.signup_agreement,
                        style: CustomLightTheme()
                            .themeData
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            CodeNoahNavigatorRouter.push(
                              context,
                              const AgreeView(),
                              direction: SlideDirection.rightToLeft,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  // sign up
  Widget buildSignUpWidget(SignUpState blocState) => Container(
        margin: BaseUtility.top(
          BaseUtility.marginNormalValue,
        ),
        child: CustomButtonWidget(
          dynamicViewExtensions: dynamicViewExtensions,
          text: AppLocalizations.of(context)!.signup_btn,
          func: blocState.email.isEmpty || blocState.password.isEmpty
              ? () {}
              : () => signUp,
          btnStatus: blocState.email.isEmpty || blocState.password.isEmpty
              ? ButtonTypes.borderPrimaryColorButton
              : ButtonTypes.primaryColorButton,
        ),
      );

  // sign in
  Widget get buildSignInWidget => Padding(
        padding: BaseUtility.top(
          BaseUtility.paddingHightValue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Padding(
                padding: BaseUtility.horizontal(
                  BaseUtility.paddingSmallValue,
                ),
                child: BodyMediumBlackText(
                  text: AppLocalizations.of(context)!.signup_sign,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  CodeNoahNavigatorRouter.push(
                    context,
                    const SignInView(),
                    direction: SlideDirection.leftToRight,
                  );
                },
                child: Padding(
                  padding: BaseUtility.horizontal(
                    BaseUtility.paddingSmallValue,
                  ),
                  child: BodyMediumMainColorText(
                    text: AppLocalizations.of(context)!.signup_sign_btn,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
