// ignore_for_file: avoid_dynamic_calls

import 'package:caffely/feature/basket/basket_view.dart';
import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/event.dart';
import 'package:caffely/feature/basket/bloc/mixin.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/feature/basket/view/order_complete/ordercomplete_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/navigator_router.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasketViewModel extends BaseState<BasketView> with BasketMixin {
  List<BasketProductModel> basketProductList = [];

  String branchId = "";

  @override
  void initState() {
    super.initState();
    basketProductList = [];
    context.read<BasketBloc>().add(LoadBasketEvent());
  }

  void orderCompleteFunc(BasketLoaded state) {
    if (basketProductList.isEmpty) {
      CodeNoahDialogs(context).showFlush(
        type: SnackType.warning,
        message: AppLocalizations.of(context)!.basket_complete_empty_error,
      );
    } else {
      CodeNoahNavigatorRouter.push(
        context,
        OrderCompleteView(
          branches: state.branches,
          basketProducts: basketProductList,
          branchId: branchId,
        ),
      );
    }
  }
}
