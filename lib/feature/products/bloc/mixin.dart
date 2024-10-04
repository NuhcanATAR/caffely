// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin ProductsMixin {
  // basket add listener
  void basketAddListenerBloc(BuildContext context, state) {
    switch (state.runtimeType) {
      case ProductBasketAddSuccessState:
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: (state as ProductBasketAddSuccessState).message,
        );
        break;
      case ProductBasketAddError:
        CodeNoahDialogs(context).showFlush(
          type: SnackType.warning,
          message: (state as ProductBasketAddSuccessState).message,
        );
        break;
      default:
        Logger().f('Eksik Case Mevcut');
    }
  }
}
