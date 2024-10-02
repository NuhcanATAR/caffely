// ignore_for_file: avoid_dynamic_calls

import 'package:caffely/feature/basket/basket_view.dart';
import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/event.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasketViewModel extends BaseState<BasketView> {
  late List<BasketProductModel> basketProductList;
  @override
  void initState() {
    super.initState();
    context.read<BasketBloc>().add(LoadBasketEvent());
    basketProductList = [];
  }
}
