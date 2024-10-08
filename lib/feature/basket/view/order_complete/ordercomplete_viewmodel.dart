import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/event.dart';
import 'package:caffely/feature/basket/bloc/mixin.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/feature/basket/view/order_complete/ordercomplete_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PaymentType {
  online,
  payAtTheDoor,
}

abstract class OrderCompleteViewModel extends BaseState<OrderCompleteView>
    with BasketMixin {
  List<SavedAdressModel> addressList = [];
  SavedAdressModel? selectedAddress;
  PaymentType? selectedPaymentType = PaymentType.online;

  List<BasketProductModel> basketProducts = [];
  @override
  void initState() {
    super.initState();
    loadAddresses();
    context.read<BasketBloc>().add(LoadBasketEvent());
  }

  Future<void> loadAddresses() async {
    final List<SavedAdressModel> addresses =
        await context.read<BasketBloc>().fetchSavedAddresses();
    setState(() {
      addressList = addresses;
    });
  }

  void orderCreateBtn(BasketLoaded state) {
    final List<BasketProductModel> basketProducts = [];

    for (final branch in state.branches) {
      final products = state.branchProducts[branch.id] ?? [];

      basketProducts.addAll(products);
    }

    if (selectedAddress != null &&
        selectedPaymentType != null &&
        state.branches.isNotEmpty &&
        basketProducts.isNotEmpty) {
      context.read<BasketBloc>().add(
            BasketOrderCreateEvent(
              selectedAddress!,
              selectedPaymentType!,
              state.branches,
              basketProducts,
            ),
          );
    } else if (widget.branches.isEmpty) {
      CodeNoahDialogs(context).showFlush(
        type: SnackType.warning,
        message: 'Sepetde Henüz Şube bulunmuyor!',
      );
    } else if (basketProducts.isEmpty) {
      CodeNoahDialogs(context).showFlush(
        type: SnackType.warning,
        message: 'Sepetde Henüz ürün bulunmuyor!',
      );
    } else {
      CodeNoahDialogs(context).showFlush(
        type: SnackType.warning,
        message: 'Sipariş bilgilerinizi işaretleyiniz!',
      );
    }
  }
}
