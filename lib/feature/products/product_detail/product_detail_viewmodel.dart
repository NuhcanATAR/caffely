// ignore_for_file: avoid_dynamic_calls

import 'package:caffely/feature/products/bloc/cubit.dart';
import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/mixin.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/feature/products/product_detail/product_detail_view.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductDetailViewModel extends BaseState<ProductDetailView>
    with ProductsMixin {
  Stream<QuerySnapshot> getFavoriteStream() {
    final userId = FirebaseService().authID;
    return FirebaseCollectionReferances.favorite.collectRef
        .where('user_id', isEqualTo: userId)
        .snapshots();
  }

  void productBasketAdd(ProductState state, int totalPrice) {
    {
      if (state.coffeSize == ProductTypeControl.notSelect ||
          state.coffeeType == ProductCoffeAvaibleTypeControl.notSelect) {
        CodeNoahDialogs(context).showFlush(
          type: SnackType.warning,
          message:
              AppLocalizations.of(context)!.products_basket_add_select_error,
        );
      } else {
        context.read<ProductBloc>().add(
              ProductBasketAddEvent(
                widget.productModel,
                state,
                totalPrice,
                context,
              ),
            );
      }
    }
  }
}
