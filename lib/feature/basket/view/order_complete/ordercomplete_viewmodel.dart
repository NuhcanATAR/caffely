import 'package:caffely/feature/basket/bloc/cubit.dart';
import 'package:caffely/feature/basket/bloc/event.dart';
import 'package:caffely/feature/basket/bloc/mixin.dart';
import 'package:caffely/feature/basket/view/order_complete/ordercomplete_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
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

  @override
  void initState() {
    super.initState();
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    final List<SavedAdressModel> addresses =
        await context.read<BasketBloc>().fetchSavedAddresses();
    setState(() {
      addressList = addresses;
    });
  }

  void orderCreateBtn() {
    if (selectedAddress != null &&
        selectedPaymentType != null &&
        widget.branches.isNotEmpty &&
        widget.basketProducts.isNotEmpty) {
      context.read<BasketBloc>().add(
            BasketOrderCreateEvent(
              selectedAddress!,
              selectedPaymentType!,
              widget.branches,
              widget.basketProducts,
            ),
          );
    } else if (widget.branches.isEmpty) {
      CodeNoahDialogs(context).showFlush(
        type: SnackType.warning,
        message: 'Sepetde Henüz Şube bulunmuyor!',
      );
    } else if (widget.basketProducts.isEmpty) {
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
