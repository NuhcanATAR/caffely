// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/sign_up/bloc/state.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin SignUpMixin {
  // logger
  final loggerPrint = CustomLoggerPrint();
  void signUpListenerBloc(BuildContext context, SignUpState state) {
    switch (state.runtimeType) {
      case SignUpSuccessState:
        loggerPrint.printInfoLog((state as SignUpSuccessState).message);

        Navigator.pop(context);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: state.message,
        );

        break;
      case SignUpErrorState:
        Navigator.pop(context);
        loggerPrint.printInfoLog((state as SignUpErrorState).message);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: state.message,
        );
        break;
      case SignUpLoadingState:
        CodeNoahDialogs(context).showAlert(
          const BodyMediumWhiteText(
            text: "Lütfen Bekleyiniz...",
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        loggerPrint.printInfoLog('Eksik Case Mevcut');
    }
  }
}
