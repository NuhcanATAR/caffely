// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/password/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin PasswordMixin {
  final loggerPrint = CustomLoggerPrint();
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
        loggerPrint.printErrorLog(state.errorMessage.toString());
      case PasswordLoadingState:
        CodeNoahDialogs(context).showLoadingAlert(
          AppIcons.accountPassword,
          AppLocalizations.of(context)!.forgot_password_loading_title,
          AppLocalizations.of(context)!.forgot_password_loading_subtitle,
          (state as PasswordLoadingState).dynamicViewExtensions,
        );
        break;
      default:
        Logger().i('Eksik Case Mevcut');
    }
  }
}
