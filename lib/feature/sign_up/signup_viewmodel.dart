import 'package:caffely/feature/sign_up/bloc/mixin.dart';
import 'package:caffely/feature/sign_up/signup_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class SignUpViewModel extends BaseState<SignUpView> with SignUpMixin {
  final formSignUpKey = GlobalKey<FormState>();

  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  late bool isAgree = false;
}
