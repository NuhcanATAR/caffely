// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/store/bloc/state.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin StoreMixin {
  void storeFavoriteListenerBloc(BuildContext context, StoresState state) {
    switch (state.runtimeType) {
      case StoreFavoriteAddSuccess:
        Logger().i((state as StoreFavoriteAddSuccess).message);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: state.message,
        );
        break;
      case StoreFavoriteAddError:
        Navigator.pop(context);
        Logger().i((state as StoreFavoriteAddError).message);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: state.message,
        );
        break;
      case StoreFavoriteAddLoading:
        CodeNoahDialogs(context).showAlert(
          const BodyMediumWhiteText(
            text: 'Lütfen Bekleyiniz...',
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        Logger().i('Eksik Case Mevcut');
    }
  }
}
