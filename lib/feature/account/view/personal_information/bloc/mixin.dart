// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/account/view/personal_information/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

mixin PersonalInformationMixin {
  // logger
  final loggerPrint = CustomLoggerPrint();
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
        loggerPrint.printErrorLog(state.error);
      case PersonalInformationUpdateLoading:
        CodeNoahDialogs(context).showAlert(
          BodyMediumWhiteText(
            text: AppLocalizations.of(context)!
                .account_personal_information_loading,
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        loggerPrint.printInfoLog('Eksik Case Mevcut');
    }
  }
}
