// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/account/view/saved_adress/bloc/cubit.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/event.dart';
import 'package:caffely/feature/account/view/saved_adress/bloc/state.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SavedAdressMixin {
  // logger
  final loggerPrint = CustomLoggerPrint();
  void savedAdressCreateListenerBloc(
    BuildContext context,
    SavedAdressState state,
  ) {
    switch (state.runtimeType) {
      case SaveAdressCreateSuccess:
        context.read<SavedAdressBloc>().add(LoadSavedAdressEvent(context));
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: (state as SaveAdressCreateSuccess).message,
        );
        break;
      case SaveAdressCreateError:
        Navigator.pop(context);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: (state as SaveAdressCreateError).errorMessage,
        );
        break;
      case SaveAdressCreateLoading:
        CodeNoahDialogs(context).showAlert(
          const BodyMediumWhiteText(
            text: 'Lütfen Bekleyiniz...',
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        loggerPrint.printInfoLog('Eksik Case Mevcut');
    }
  }

  void savedAdressEditListenerBloc(
    BuildContext context,
    SavedAdressState state,
  ) {
    switch (state.runtimeType) {
      case SaveAdressUpdateSuccess:
        context.read<SavedAdressBloc>().add(LoadSavedAdressEvent(context));
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: (state as SaveAdressUpdateSuccess).message,
        );
        break;
      case SaveAdressUpdateError:
        Navigator.pop(context);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: (state as SaveAdressUpdateError).errorMessage,
        );
        break;
      case SaveAdressUpdateLoading:
        CodeNoahDialogs(context).showAlert(
          const BodyMediumWhiteText(
            text: 'Lütfen Bekleyiniz...',
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        loggerPrint.printInfoLog('Eksik Case Mevcut');
    }
  }

  void savedAdressDeleteListenerBloc(
    BuildContext context,
    SavedAdressState state,
  ) {
    switch (state.runtimeType) {
      case SaveAdressDeleteSuccess:
        context.read<SavedAdressBloc>().add(LoadSavedAdressEvent(context));
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.success,
          message: (state as SaveAdressDeleteSuccess).message,
        );
        break;
      case SaveAdressDeleteError:
        Navigator.pop(context);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: (state as SaveAdressDeleteError).errorMessage,
        );
        break;
      default:
        loggerPrint.printInfoLog('Eksik Case Mevcut');
    }
  }
}
