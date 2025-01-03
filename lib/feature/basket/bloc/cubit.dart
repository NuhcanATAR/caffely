// ignore_for_file: invalid_use_of_visible_for_testing_member, unused_local_variable, avoid_dynamic_calls,

import 'package:caffely/feature/basket/bloc/event.dart';
import 'package:caffely/feature/basket/bloc/state.dart';
import 'package:caffely/feature/basket/view/order_complete/order_complete_viewmodel.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/order_basket_control.dart';
import 'package:caffely/product/core/base/helper/product_type_control.dart';
import 'package:caffely/product/core/base/helper/show_dialogs.dart';
import 'package:caffely/product/core/database/firebase_constant.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_model/basket_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/model/savedadress_model/savedadress_model.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  // logger
  final loggerPrint = CustomLoggerPrint();
  BasketBloc() : super(BasketInitialState()) {
    on<LoadBasketEvent>(basketList);

    on<BasketOrderCreateEvent>(orderCreate);
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

        final Map<String, List<BasketProductModel>> branchProducts = {};

        for (final branch in branches) {
          final QuerySnapshot productsQuery = await FirebaseCollectionReferances
              .basket.collectRef
              .doc(FirebaseService().authID)
              .collection(FirebaseCollectionReferances.branch.name)
              .doc(branch.id)
              .collection(FirebaseCollectionReferances.product.name)
              .get();

          final List<BasketProductModel> products =
              productsQuery.docs.map((doc) {
            return BasketProductModel.fromJson(
              doc.data() as Map<String, dynamic>,
            );
          }).toList();

          branchProducts[branch.id] = products;
        }

        emit(
          BasketLoaded(
            isBasket: true,
            branches: branches,
            branchProducts: branchProducts,
          ),
        );
      } else {
        emit(
          BasketLoaded(
            isBasket: false,
            branches: const [],
            branchProducts: const {},
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

    int productPrice = 0;

    if (productModel.size == ProductTypeControl.small.productTypeValue) {
      productPrice = product.price;
    } else if (productModel.size ==
        ProductTypeControl.middle.productTypeValue) {
      productPrice = product.price + product.middlePrice;
    } else if (productModel.size == ProductTypeControl.large.productTypeValue) {
      productPrice = product.price + product.largePrice;
    }

    try {
      await branchDocRef.update(
        BasketBranchModel(
          basketTotal: -productModel.quanity * productPrice,
          totalQuanity: -productModel.quanity,
        ).toBranchDocUpdate(),
      );

      if (basketProducts.length == 1) {
        await productDocRef.delete();
        await branchDocRef.delete();
        if (!context.mounted) return;
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      loggerPrint.printErrorLog('Hata:  $e');
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

      int productPrice = 0;
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

        await productDocRef.update(
          BasketProductModel(
            quanity: newQuantity,
            productTotal: newQuantity * productPrice,
          ).toProductDocUpdate(),
        );

        await branchDocRef.update(
          BasketBranchModel(
            totalQuanity: 1,
            basketTotal: productPrice,
          ).toBranchDocUpdate(),
        );
      }
    } catch (e) {
      loggerPrint.printErrorLog(
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

        int productPrice = 0;
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

            await productDocRef.update(
              BasketProductModel(
                quanity: newQuantity,
                productTotal: newQuantity * productPrice,
              ).toProductDocUpdate(),
            );

            await branchDocRef.update(
              BasketBranchModel(
                totalQuanity: -1,
                basketTotal: -productPrice,
              ).toBranchDocUpdate(),
            );
          }
        }
      } else {
        await CodeNoahDialogs(
          context,
        ).showFlush(
          type: SnackType.warning,
          message: AppLocalizations.of(context)!.basket_quanity_erorr,
        );
      }
    } catch (e) {
      loggerPrint.printErrorLog(
        'Hata: $e',
      );
    }
  }

  Future<List<SavedAdressModel>> fetchSavedAddresses() async {
    final QuerySnapshot querySnapshot = await FirebaseCollectionReferances
        .saved_adress.collectRef
        .where(FirebaseConstant.userId, isEqualTo: FirebaseService().authID)
        .where(FirebaseConstant.isDeleted, isEqualTo: false)
        .get();

    return querySnapshot.docs.map((doc) {
      return SavedAdressModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> orderCreate(
    BasketOrderCreateEvent event,
    Emitter<BasketState> emit,
  ) async {
    emit(BaskekOrderCompleteLoading());
    try {
      final orderRef = await FirebaseCollectionReferances.orders.collectRef.add(
        OrderModel(
          id: '',
          userId: FirebaseService().authID!,
          paymentType: event.paymentType == PaymentType.online
              ? OrderPaymentType.online.value
              : OrderPaymentType.payAtTheDoor.value,
          adressTitle: event.selectAdress.adressTitle,
          adressCity: event.selectAdress.adressCity,
          adressDistrict: event.selectAdress.adressDistrict,
          adressStreet: event.selectAdress.adressStreet,
          adressFloor: event.selectAdress.adressFloor,
          adressApartmentNo: event.selectAdress.adressAparmentNo,
          adressDirections: event.selectAdress.adressDirections,
          contactName: event.selectAdress.contactName,
          contactSurname: event.selectAdress.contactSurname,
          contactPhoneNumber: event.selectAdress.contactPhoneNumber,
        ).toOrderAdd(),
      );

      final String orderId = orderRef.id;
      await orderRef.update(OrderModel(id: orderId).toOrderDocUpdate());

      await FirebaseCollectionReferances.orders.collectRef
          .doc(orderId)
          .collection(FirebaseCollectionReferances.basket.name)
          .doc(orderId)
          .set(
            BasketModel(
              id: orderId,
              basketStatus: BasketMainStatusControl.orderReceived.value,
            ).toBasketSetFirebase(),
          );

      for (final branchModel in event.basketBranchModel) {
        await FirebaseCollectionReferances.orders.collectRef
            .doc(orderId)
            .collection(FirebaseCollectionReferances.basket.name)
            .doc(orderId)
            .collection(FirebaseCollectionReferances.branch.name)
            .doc(branchModel.id)
            .set(
              BasketBranchModel(
                id: branchModel.id,
                basketTotal: branchModel.basketTotal,
                totalQuanity: branchModel.totalQuanity,
                status: OrderBranchStatusControl.orderReceived.value,
              ).toBranchAdd(),
            );

        final List<BasketProductModel> productsForBranch = event
            .basketProductModel
            .where((product) => product.branchId == branchModel.id)
            .toList();

        for (final productModel in productsForBranch) {
          await FirebaseCollectionReferances.orders.collectRef
              .doc(orderId)
              .collection(FirebaseCollectionReferances.basket.name)
              .doc(orderId)
              .collection(FirebaseCollectionReferances.branch.name)
              .doc(branchModel.id)
              .collection(FirebaseCollectionReferances.product.name)
              .doc(productModel.id)
              .set(
                BasketProductModel(
                  id: productModel.id,
                  avaible: productModel.avaible,
                  productId: productModel.productId,
                  productTotal: productModel.productTotal,
                  quanity: productModel.quanity,
                  size: productModel.size,
                  status: productModel.status,
                  branchId: productModel.branchId,
                ).toBranchProductSetFirebase(),
              );
        }
      }

      for (final branchModel in event.basketBranchModel) {
        for (final productModel in event.basketProductModel) {
          await FirebaseCollectionReferances.basket.collectRef
              .doc(FirebaseService().authID)
              .collection(FirebaseCollectionReferances.branch.name)
              .doc(branchModel.id)
              .collection(FirebaseCollectionReferances.product.name)
              .doc(productModel.id)
              .delete();
        }
        await FirebaseCollectionReferances.basket.collectRef
            .doc(FirebaseService().authID)
            .collection(FirebaseCollectionReferances.branch.name)
            .doc(branchModel.id)
            .delete();
      }

      await FirebaseCollectionReferances.basket.collectRef
          .doc(FirebaseService().authID)
          .delete();
      if (!event.context.mounted) return;
      emit(
        BasketOrderCompleteState(
          AppLocalizations.of(event.context)!.basket_order_complete_success,
        ),
      );
    } catch (e) {
      emit(
        BasketOrderCompleteError(
          AppLocalizations.of(event.context)!.basket_order_complete_error,
        ),
      );
    }
  }
}
