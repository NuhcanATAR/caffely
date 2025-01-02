import 'package:caffely/feature/sign_up/bloc/cubit.dart';
import 'package:caffely/feature/sign_up/bloc/event.dart';
import 'package:caffely/feature/sign_up/bloc/mixin.dart';
import 'package:caffely/feature/sign_up/bloc/state.dart';
import 'package:caffely/feature/sign_up/sign_up_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignUpViewModel extends BaseState<SignUpView> with SignUpMixin {
  final formSignUpKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isAgree = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUp(SignUpState blocState) {
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
          message: AppLocalizations.of(context)!.signup_agreement_error,
        );
      }
    }
  }

  void agreeCheckBox(bool? value) {
    setState(() {
      isAgree = value!;
    });
  }
}
