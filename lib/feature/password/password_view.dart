import 'package:caffely/feature/password/bloc/cubit.dart';
import 'package:caffely/feature/password/bloc/event.dart';
import 'package:caffely/feature/password/bloc/state.dart';
import 'package:caffely/feature/password/password_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/button_control.dart';
import 'package:caffely/product/util/base_utility.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:caffely/product/widget/text_widget/title_large_text.dart';
import 'package:caffely/product/widget/widget/button_widget.dart';
import 'package:caffely/product/widget/widget/emailfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends PasswordViewmodel {
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
      body: BlocConsumer<PasswordBloc, PasswordState>(
        listener: passwordResetEmailListenerBloc,
        builder: (BuildContext context, state) {
          return Form(
            key: formPasswordKey,
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
                        Padding(
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
                                    text: AppLocalizations.of(context)!
                                        .forgot_password_title,
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
                                    text: AppLocalizations.of(context)!
                                        .forgot_password_subtitle,
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
                          hintText: AppLocalizations.of(context)!
                              .forgot_password_email,
                          onChanged: (String value) {
                            context.read<PasswordBloc>().add(
                                  PasswordEmailEvent(value),
                                );
                          },
                          isLabelText: true,
                        ),
                      ],
                    ),
                  ),
                  // footer
                  CustomButtonWidget(
                    dynamicViewExtensions: dynamicViewExtensions,
                    text: AppLocalizations.of(context)!
                        .forgot_password_correct_btn,
                    func: state.email.isEmpty
                        ? () {}
                        : () {
                            if (formPasswordKey.currentState!.validate()) {
                              context.read<PasswordBloc>().add(
                                    PasswordResetEvent(
                                      state.email,
                                      dynamicViewExtensions,
                                      context,
                                    ),
                                  );
                              emailController.clear();
                            }
                          },
                    btnStatus: state.email.isEmpty
                        ? ButtonTypes.borderPrimaryColorButton
                        : ButtonTypes.primaryColorButton,
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
