// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/account/view/personal_information/bloc/state.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin PersonalInformationMixin {
  void personalInformationUpdateListenerBloc(BuildContext context, state) {
    switch (state.runtimeType) {
      case PersonalInformationUpdateSuccess:
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: (state as PersonalInformationUpdateSuccess).message,
        );
        break;
      case PersonalInformationUpdateError:
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: (state as PersonalInformationUpdateError).error,
        );
      case PersonalInformationUpdateLoading:
        CodeNoahDialogs(context).showAlert(
          const BodyMediumWhiteText(
            text: 'Lütfen bekleyiniz...',
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        Logger().i('Eksik Case Mevcut');
    }
  }
}
