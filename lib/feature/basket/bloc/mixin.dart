// ignore_for_file: type_literal_in_constant_pattern

import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/feature/basket/view/order_success/order_success_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

mixin BasketMixin {
  // order create
  void basketOrderCreateListenerBloc(BuildContext context, state) {
    switch (state.runtimeType) {
      case BasketOrderCompleteState:
        Logger().i((state as BasketOrderCompleteState).message);
        Navigator.pop(context);
        CodeNoahNavigatorRouter.pushAndRemoveUntil(
          context,
          const OrderSuccessView(),
        );
        break;
      case BasketOrderCompleteError:
        Logger().i((state as BasketOrderCompleteError).message);
        Navigator.pop(context);
        CodeNoahDialogs(context).showFlush(
          type: SnackType.error,
          message: state.message,
        );
        break;
      case BaskekOrderCompleteLoading:
        CodeNoahDialogs(context).showAlert(
          BodyMediumWhiteText(
            text: AppLocalizations.of(context)!.basket_loading_title,
            textAlign: TextAlign.center,
          ),
        );
        break;
      default:
        Logger().i('Eksik Case Mevcut');
    }
  }
}
