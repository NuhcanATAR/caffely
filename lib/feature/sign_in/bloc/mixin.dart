// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/sign_in/bloc/state.dart';
import 'package:caffely/feature/sign_in/signin_loading_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/constants/icon.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin SignInMixin {
  void signInListenerBloc(BuildContext context, SignInState state) {
    switch (state.runtimeType) {
      case SignInSuccessState:
        Logger().i((state as SignInSuccessState).message);
        Navigator.pop(context);
        CodeNoahNavigatorRouter.pushAndRemoveUntil(
          context,
          const SignInLoadingView(),
          direction: SlideDirection.rightToLeft,
        );
        break;
      case SignInErrorState:
        Navigator.pop(context);
        Logger().i((state as SignInErrorState).message);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: state.message,
        );
        break;
      case SignInLoadingState:
        CodeNoahDialogs(context).showLoadingAlert(
          AppIcons.accountSignIn,
          AppLocalizations.of(context)!.sign_loading_title,
          AppLocalizations.of(context)!.sign_loading_subtitle,
          (state as SignInLoadingState).dynamicViewExtensions,
        );
        break;
      default:
        Logger().i('Eksik Case Mevcut');
    }
  }

  void signInGoogleListenerBloc(BuildContext context, SignInState state) {
    switch (state.runtimeType) {
      case SignInGoogleAuthSuccess:
        Logger().i((state as SignInGoogleAuthSuccess).message);
        Navigator.pop(context);
        CodeNoahNavigatorRouter.pushAndRemoveUntil(
          context,
          const SignInLoadingView(),
          direction: SlideDirection.rightToLeft,
        );
        break;
      case SignInGoogleAuthError:
        Navigator.pop(context);
        Logger().i((state as SignInGoogleAuthError).message);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: state.message,
        );
        break;
      case SignInGoogleAuthLoading:
        CodeNoahDialogs(context).showLoadingAlert(
          AppIcons.accountSignIn,
          AppLocalizations.of(context)!.sign_loading_title,
          AppLocalizations.of(context)!.sign_loading_subtitle,
          (state as SignInGoogleAuthLoading).dynamicViewExtensions,
        );
        break;
      default:
        Logger().i('Eksik Case Mevcut');
    }
  }
}
