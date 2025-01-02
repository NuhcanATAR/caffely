import 'package:caffely/feature/orders/bloc/cubit.dart';
import 'package:caffely/feature/orders/bloc/event.dart';
import 'package:caffely/feature/orders/view/order_detail/orderdetail_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OrderDetailViewModel extends BaseState<OrderDetailView> {
  List<BasketBranchModel> branches = [];

  int mainTotalPrice = 0;
  int mainTotalQuanity = 0;

  @override
  void initState() {
    super.initState();

    context.read<OrderBloc>().add(
          LoadBranchesEvent(
            widget.orderModel.id,
            context,
          ),
        );
    mainTotalQuanity = 0;
    mainTotalQuanity = 0;
  }
}
