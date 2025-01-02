// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/complete/bloc/state.dart';
import 'package:caffely/feature/complete/complete_success_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin ProfileCompleteMixin {
  void profileCompleteListenerBloc(
    BuildContext context,
    ProfileCompleteState state,
  ) {
    switch (state.runtimeType) {
      case ProfileCompleteSuccess:
        Navigator.pop(context);
        CodeNoahNavigatorRouter.pushAndRemoveUntil(
          context,
          const CompleteSuccessView(),
          direction: SlideDirection.rightToLeft,
        );
      case ProfileCompleteError:
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: (state as ProfileCompleteError).errorMessage,
        );
      case ProfileCompleteLoading:
        CodeNoahDialogs(context).showLoadingAlert(
          AppIcons.accountSignIn,
          AppLocalizations.of(context)!.sign_complete_loading_title,
          AppLocalizations.of(context)!.sign_complete_loading_subtitle,
          (state as ProfileCompleteLoading).dynamicViewExtensions,
        );
        break;
      default:
        Logger().e('Eksik Case Mevcut');
    }
  }
}
