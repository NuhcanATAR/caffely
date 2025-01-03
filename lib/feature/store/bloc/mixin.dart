// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/store/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

mixin StoreMixin {
  // logger
  final loggerPrint = CustomLoggerPrint();
  void storeFavoriteListenerBloc(BuildContext context, StoresState state) {
    switch (state.runtimeType) {
      case StoreFavoriteAddSuccess:
        loggerPrint.printInfoLog((state as StoreFavoriteAddSuccess).message);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: state.message,
        );
        break;
      case StoreFavoriteAddError:
        Navigator.pop(context);
        loggerPrint.printInfoLog((state as StoreFavoriteAddError).message);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: state.message,
        );
        break;
      case StoreFavoriteAddLoading:
        CodeNoahDialogs(context).showAlert(
          BodyMediumWhiteText(
            text: AppLocalizations.of(context)!
                .stores_information_favorite_loading_title,
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        loggerPrint.printInfoLog('Eksik Case Mevcut');
    }
  }
}
