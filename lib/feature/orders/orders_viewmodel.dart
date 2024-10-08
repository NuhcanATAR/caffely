import 'package:caffely/feature/orders/bloc/cubit.dart';
import 'package:caffely/feature/orders/bloc/event.dart';
import 'package:caffely/feature/orders/orders_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OrdersViewModel extends BaseState<OrdersView> {
  List<BasketBranchModel> branches = [];

  @override
  void initState() {
    super.initState();
    // OrderListEvent'i yükle
    context.read<OrderBloc>().add(LoadOrderEvent());
  }
}
