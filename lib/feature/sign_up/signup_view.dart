import 'package:caffely/feature/agree/agree_view.dart';
import 'package:caffely/feature/sign_in/signin_view.dart';
import 'package:caffely/feature/sign_up/bloc/cubit.dart';
import 'package:caffely/feature/sign_up/bloc/event.dart';
import 'package:caffely/feature/sign_up/bloc/state.dart';
import 'package:caffely/feature/sign_up/signup_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/theme/light_theme.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/emailfield_widget.dart';
import 'package:caffely/product/widget/widget/passwordfield_widget.dart';
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
            IconSizedsUtility.normalSize,
            IconSizedsUtility.normalSize,
          ),
        ),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: signUpListenerBloc,
        builder: (BuildContext context, blocState) {
          return Form(
            key: formSignUpKey,
            child: Padding(
              padding: PaddingSizedsUtility.all(
                PaddingSizedsUtility.normalPaddingValue,
              ),
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
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.bottom(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: TitleLargeBlackBoldText(
                              text: AppLocalizations.of(context)!
                                  .signup_email_title,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        // sub title
                        SizedBox(
                          width: dynamicViewExtensions.maxWidth(context),
                          child: Padding(
                            padding: PaddingSizedsUtility.bottom(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: BodyMediumBlackText(
                              text: AppLocalizations.of(context)!
                                  .signup_email_subtitle,
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
                    hintText: AppLocalizations.of(context)!.signup_email,
                    onChanged: (String value) {
                      context.read<SignUpBloc>().add(SignUpEmailEvent(value));
                    },
                    isLabelText: true,
                  ),
                  // password
                  CustomPasswordFieldWidget(
                    passwordController: passwordController,
                    hintText: AppLocalizations.of(context)!.signup_password,
                    onChanged: (String value) {
                      context
                          .read<SignUpBloc>()
                          .add(SignUpPasswordEvent(value));
                    },
                    isValidator: true,
                    isLabelText: true,
                  ),
                  // agree
                  Padding(
                    padding: PaddingSizedsUtility.top(
                      PaddingSizedsUtility.normalPaddingValue,
                    ),
                    child: Row(
                      children: <Widget>[
                        // check box
                        Checkbox(
                          value: isAgree,
                          onChanged: (bool? value) {
                            setState(() {
                              isAgree = value!;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                        // agree text
                        Expanded(
                          child: Padding(
                            padding: PaddingSizedsUtility.horizontal(
                              PaddingSizedsUtility.normalPaddingValue,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context)!
                                    .signup_user_agreement,
                                style: CustomLightTheme()
                                    .themeData
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .signup_agreement,
                                    style: CustomLightTheme()
                                        .themeData
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
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
                  ),

                  // sign up
                  Container(
                    margin: MarginSizedsUtility.top(
                      MarginSizedsUtility.normalMarginValue,
                    ),
                    child: CustomButtonWidget(
                      dynamicViewExtensions: dynamicViewExtensions,
                      text: AppLocalizations.of(context)!.signup_btn,
                      func:
                          blocState.email.isEmpty || blocState.password.isEmpty
                              ? () {}
                              : () {
                                  if (formSignUpKey.currentState!.validate()) {
                                    if (isAgree == true) {
                                      context.read<SignUpBloc>().add(
                                            SignUpUserEvent(
                                              blocState.email,
                                              blocState.password,
                                              context,
                                            ),
                                          );
                                      emailController.clear();
                                      passwordController.clear();
                                      isAgree = false;
                                    } else {
                                      CodeNoahDialogs(context).showFlush(
                                        type: SnackType.warning,
                                        message: AppLocalizations.of(context)!
                                            .signup_agreement_error,
                                      );
                                    }
                                  }
                                },
                      btnStatus:
                          blocState.email.isEmpty || blocState.password.isEmpty
                              ? ButtonTypes.borderPrimaryColorButton
                              : ButtonTypes.primaryColorButton,
                    ),
                  ),
                  // sign in
                  Padding(
                    padding: PaddingSizedsUtility.top(
                      PaddingSizedsUtility.hightPaddingValue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Padding(
                            padding: PaddingSizedsUtility.horizontal(
                              PaddingSizedsUtility.smallPaddingValue,
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
                              padding: PaddingSizedsUtility.horizontal(
                                PaddingSizedsUtility.smallPaddingValue,
                              ),
                              child: BodyMediumMainColorText(
                                text: AppLocalizations.of(context)!
                                    .signup_sign_btn,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
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
