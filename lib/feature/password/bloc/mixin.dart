// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/password/bloc/state.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin PasswordMixin {
  void passwordResetEmailListenerBloc(
    BuildContext context,
    PasswordState state,
  ) {
    switch (state.runtimeType) {
      case PasswordSuccessState:
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: (state as PasswordSuccessState).message,
        );
      case PasswordErrorState:
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.warning,
          message: (state as PasswordErrorState).errorMessage,
        );
      case PasswordLoadingState:
        CodeNoahDialogs(context).showLoadingAlert(
          AppIcons.accountPassword,
          'Hesabınıza Giriş Yapılıyor',
          'Lütfen Bekleyiniz...',
          (state as PasswordLoadingState).dynamicViewExtensions,
        );
        break;
      default:
        Logger().i('Eksik Case Mevcut');
    }
  }
}
