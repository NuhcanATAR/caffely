// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/sign_up/bloc/state.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin SignUpMixin {
  void signUpListenerBloc(BuildContext context, SignUpState state) {
    switch (state.runtimeType) {
      case SignUpSuccessState:
        Logger().i((state as SignUpSuccessState).message);

        Navigator.pop(context);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: state.message,
        );

        break;
      case SignUpErrorState:
        Navigator.pop(context);
        Logger().i((state as SignUpErrorState).message);
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
        Logger().i('Eksik Case Mevcut');
    }
  }
}
