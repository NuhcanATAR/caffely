import 'package:caffely/feature/password/bloc/mixin.dart';
import 'package:caffely/feature/password/password_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class PasswordViewmodel extends BaseState<PasswordView>
    with PasswordMixin {
  final formPasswordKey = GlobalKey<FormState>();

  late TextEditingController emailController = TextEditingController();
}
