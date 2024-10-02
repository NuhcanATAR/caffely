// ignore_for_file: invalid_use_of_visible_for_testing_member, unused_local_variable, avoid_dynamic_calls

import 'package:caffely/feature/basket/bloc/event.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketInitialState()) {
    on<LoadBasketEvent>(basketList);
  }

  Future<void> basketList(
    LoadBasketEvent event,
    Emitter<BasketState> emit,
  ) async {
    emit(BasketLoadingState());

    try {
      final DocumentSnapshot basketCollectionDoc =
          await FirebaseCollectionReferances.basket.collectRef
              .doc(FirebaseService().authID)
              .get();

      if (basketCollectionDoc.exists) {
        final QuerySnapshot basketBranchesQuery =
            await FirebaseCollectionReferances.basket.collectRef
                .doc(FirebaseService().authID)
                .collection(FirebaseCollectionReferances.branch.name)
                .get();

        final List<BasketBranchModel> branches = basketBranchesQuery.docs
            .map(
              (doc) => BasketBranchModel.fromJson(
                doc.data() as Map<String, dynamic>,
              ),
            )
            .toList();

        emit(
          BasketLoaded(
            isBasket: true,
            branches: branches,
          ),
        );
      } else {
        emit(
          BasketLoaded(
            isBasket: false,
            branches: const [],
          ),
        );
      }
    } catch (e) {
      emit(BasketError());
    }
  }

  void toggleProductsVisibility() {
    if (state is BasketLoaded) {
      final currentState = state as BasketLoaded;
      emit(
        currentState.copyWith(
          isProductsVisible: !currentState.isProductsVisible,
        ),
      );
    }
  }

  Future<void> productRemove(
    BasketBranchModel branchesModel,
    BasketProductModel productModel,
    ProductModel product,
    List<BasketProductModel> basketProducts,
    BuildContext context,
  ) async {
    final productDocRef = FirebaseCollectionReferances.basket.collectRef
        .doc(FirebaseService().authID)
        .collection(FirebaseCollectionReferances.branch.name)
        .doc(branchesModel.id)
        .collection(FirebaseCollectionReferances.product.name)
        .doc(productModel.id);

    final branchDocRef = FirebaseCollectionReferances.basket.collectRef
        .doc(FirebaseService().authID)
        .collection(FirebaseCollectionReferances.branch.name)
        .doc(branchesModel.id);

    final basketDocRef = FirebaseCollectionReferances.basket.collectRef
        .doc(FirebaseService().authID);

    late int productPrice = 0;

    if (productModel.size == ProductTypeControl.small.productTypeValue) {
      productPrice = product.price;
    } else if (productModel.size ==
        ProductTypeControl.middle.productTypeValue) {
      productPrice = product.price + product.middlePrice;
    } else if (productModel.size == ProductTypeControl.large.productTypeValue) {
      productPrice = product.price + product.largePrice;
    }

    try {
      await branchDocRef.update({
        'basket_total':
            FieldValue.increment(-productModel.quanity * productPrice),
        'total_quanity': FieldValue.increment(-productModel.quanity),
      });

      await productDocRef.delete();

      if (basketProducts.length == 1) {
        await basketDocRef.delete();
        if (!context.mounted) return;
        Navigator.pop(context);
      }
    } catch (e) {
      Logger().f('Hata:  $e');
    }
  }

  Future<void> productQuanityAdd(
    BasketBranchModel branchesModel,
    BasketProductModel productModel,
    ProductModel product,
    List<BasketProductModel> basketProducts,
  ) async {
    try {
      final productDocRef = FirebaseCollectionReferances.basket.collectRef
          .doc(
            FirebaseService().authID,
          )
          .collection(
            FirebaseCollectionReferances.branch.name,
          )
          .doc(
            branchesModel.id,
          )
          .collection(
            FirebaseCollectionReferances.product.name,
          )
          .doc(
            productModel.id,
          );

      final branchDocRef = FirebaseCollectionReferances.basket.collectRef
          .doc(
            FirebaseService().authID,
          )
          .collection(
            FirebaseCollectionReferances.branch.name,
          )
          .doc(
            branchesModel.id,
          );

      late int productPrice = 0;
      if (productModel.size == ProductTypeControl.small.productTypeValue) {
        productPrice = product.price;
      } else if (productModel.size ==
          ProductTypeControl.middle.productTypeValue) {
        productPrice = product.price + product.middlePrice;
      } else if (productModel.size ==
          ProductTypeControl.large.productTypeValue) {
        productPrice = product.price + product.largePrice;
      }

      final snapshot = await productDocRef.get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final currentQuantity = data['quanity'] ?? 0;
        final newQuantity = currentQuantity + 1;

        await productDocRef.update({
          'quanity': newQuantity,
          'product_total': newQuantity * productPrice,
        });

        await branchDocRef.update({
          'total_quanity': FieldValue.increment(
            1,
          ),
          'basket_total': FieldValue.increment(
            productPrice,
          ),
        });
      }
    } catch (e) {
      Logger().f(
        'Hata: $e',
      );
    }
  }

  Future<void> productQuanityReduce(
    BasketBranchModel branchesModel,
    BasketProductModel productModel,
    ProductModel product,
    List<BasketProductModel> basketProducts,
    BuildContext context,
  ) async {
    try {
      if (productModel.quanity != 1) {
        final productDocRef = FirebaseCollectionReferances.basket.collectRef
            .doc(
              FirebaseService().authID,
            )
            .collection(
              FirebaseCollectionReferances.branch.name,
            )
            .doc(
              branchesModel.id,
            )
            .collection(
              FirebaseCollectionReferances.product.name,
            )
            .doc(
              productModel.id,
            );

        final branchDocRef = FirebaseCollectionReferances.basket.collectRef
            .doc(
              FirebaseService().authID,
            )
            .collection(
              FirebaseCollectionReferances.branch.name,
            )
            .doc(
              branchesModel.id,
            );

        late int productPrice = 0;
        if (productModel.size == ProductTypeControl.small.productTypeValue) {
          productPrice = product.price;
        } else if (productModel.size ==
            ProductTypeControl.middle.productTypeValue) {
          productPrice = product.price + product.middlePrice;
        } else if (productModel.size ==
            ProductTypeControl.large.productTypeValue) {
          productPrice = product.price + product.largePrice;
        }

        final productSnapshot = await productDocRef.get();
        if (productSnapshot.exists) {
          final data = productSnapshot.data() as Map<String, dynamic>;
          final currentQuantity = data['quanity'] ?? 0;

          if (currentQuantity > 0) {
            final newQuantity = currentQuantity - 1;

            await productDocRef.update({
              'quanity': newQuantity,
              'product_total': newQuantity * productPrice,
            });

            await branchDocRef.update({
              'total_quanity': FieldValue.increment(
                -1,
              ),
              'basket_total': FieldValue.increment(
                -productPrice,
              ),
            });
          }
        }
      } else {
        await CodeNoahDialogs(
          context,
        ).showFlush(
          type: SnackType.warning,
          message: 'Adet değeri minimum 1 olmalı',
        );
      }
    } catch (e) {
      Logger().f(
        'Hata: $e',
      );
    }
  }
}
