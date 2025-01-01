// ignore_for_file: avoid_dynamic_calls

import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/base/helper/orderbasket_control.dart';
import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // logger
  final loggerPrint = CustomLoggerPrint();

  List<ProductModel> productList = [];
  List<ProductModel> allProducts = [];

  Map<String, bool> favoriteStatus = {};
  ProductBloc() : super(const ProductInitialState()) {
    on<ProductIncrementEvent>((event, emit) {
      emit(
        ProductUpdatedState(
          state.coffeeType,
          state.coffeSize,
        ),
      );
    });

    on<ProductDecrementEvent>((event, emit) {
      emit(
        ProductUpdatedState(
          state.coffeeType,
          state.coffeSize,
        ),
      );
    });

    on<ProductAvaibleEvent>((event, emit) {
      emit(
        ProductUpdatedState(
          event.isAvaible,
          state.coffeSize,
        ),
      );
    });

    on<ProductCoffeSizeEvent>((event, emit) {
      emit(
        ProductUpdatedState(
          state.coffeeType,
          event.isCoffeSize,
        ),
      );
    });

    on<SearchProducts>(_onSearchStores);
    on<LoadProducts>(_onLoadProducts);
    on<ProductFavoriteCreateEvent>(storeFavoriteAdd);
    on<ProductBasketAddEvent>(productBasketAdd);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      final QuerySnapshot snapshotProducts = await FirebaseCollectionReferances
          .product.collectRef
          .where('is_deleted', isEqualTo: false)
          .get();

      productList = snapshotProducts.docs
          .map(
            (doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      allProducts = List.from(productList);

      emit(ProductLoaded(productList, const []));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchStores(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductsLoading());
    try {
      if (event.query.isEmpty) {
        emit(ProductLoaded(allProducts, const []));
        return;
      }

      final List<ProductModel> filteredStores = productList.where((store) {
        final storeNameLower = store.title.toLowerCase();
        final queryLower = event.query.toLowerCase();
        return storeNameLower.contains(queryLower);
      }).toList();

      emit(ProductLoaded(filteredStores, const []));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> storeFavoriteAdd(
    ProductFavoriteCreateEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductFavoriteAddLoading());
    try {
      if (event.isFavoriteStatus) {
        final docRef =
            await FirebaseCollectionReferances.favorite.collectRef.add({
          'id': null,
          'product_id': event.productId,
          'store_id': '',
          'user_id': FirebaseService().authID,
          'date': FieldValue.serverTimestamp(),
        });

        final String docId = docRef.id;
        await docRef.update({'id': docId});
      } else {
        await FirebaseCollectionReferances.favorite.collectRef
            .doc(event.favoriteId)
            .delete();
      }
      if (!event.context.mounted) return;
      emit(
        ProductFavoriteAddSuccess(
          event.isFavoriteStatus
              ? AppLocalizations.of(event.context)!
                  .products_store_favorite_add_success
              : AppLocalizations.of(event.context)!
                  .products_store_favorite_delete_success,
        ),
      );
    } catch (e) {
      emit(
        ProductFavoriteAddError(
          AppLocalizations.of(event.context)!.products_favorite_error,
        ),
      );
    }
  }

  Future<void> productBasketAdd(
    ProductBasketAddEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final basketDoc = FirebaseCollectionReferances.basket.collectRef
          .doc(FirebaseService().authID);
      final basketCollection = await basketDoc.get();

      if (basketCollection.exists) {
        loggerPrint.printInfoLog('Sepette ürün var');

        final branchDoc = basketDoc
            .collection(FirebaseCollectionReferances.branch.name)
            .doc(event.productModel.storeId);

        final branchCollection = await branchDoc.get();

        if (branchCollection.exists) {
          Logger().f('Şube zaten sepette');

          final productQuery = await basketDoc
              .collection(FirebaseCollectionReferances.branch.name)
              .doc(event.productModel.storeId)
              .collection(FirebaseCollectionReferances.product.name)
              .where('product_id', isEqualTo: event.productModel.id)
              .where(
                'avaible',
                isEqualTo: state.coffeeType.coffeAvaibleTypeValue,
              )
              .where('size', isEqualTo: state.coffeSize.productTypeValue)
              .get();

          if (productQuery.docs.isNotEmpty) {
            final productDoc = productQuery.docs.first;
            final currentQuantity = productDoc['quanity'];
            final newQuantity = currentQuantity + 1;

            await productDoc.reference.update({
              'quanity': newQuantity,
              'product_total': FieldValue.increment(event.totalPrice),
            });

            loggerPrint.printInfoLog('Ürün miktarı güncellendi: $newQuantity');

            final branchQuery = await basketDoc
                .collection(FirebaseCollectionReferances.branch.name)
                .doc(event.productModel.storeId)
                .get();

            if (branchQuery.exists) {
              final currentBasketTotal = branchQuery['basket_total'];
              final currentTotalQuantity = branchQuery['total_quanity'];

              await branchDoc.update({
                'basket_total': currentBasketTotal + event.totalPrice,
                'total_quanity': currentTotalQuantity + 1,
                'status': OrderBranchStatusControl.orderReceived.value,
              });

              loggerPrint.printInfoLog(
                'Şube bilgileri güncellendi: basket_total ve total_quanity',
              );
            }
          } else {
            await addNewProductToBasket(
              state,
              basketDoc,
              event.totalPrice,
              event.productModel,
              event.productModel.storeId,
            );
            final branchQuery = await basketDoc
                .collection(FirebaseCollectionReferances.branch.name)
                .doc(event.productModel.storeId)
                .get();

            if (branchQuery.exists) {
              final currentBasketTotal = branchQuery['basket_total'];
              final currentTotalQuantity = branchQuery['total_quanity'];

              await branchDoc.update({
                'basket_total': currentBasketTotal + event.totalPrice,
                'total_quanity': currentTotalQuantity + 1,
                'status': OrderBranchStatusControl.orderReceived.value,
              });

              loggerPrint.printInfoLog(
                'Şube bilgileri güncellendi: basket_total ve total_quanity',
              );
            }
          }
        } else {
          loggerPrint.printInfoLog('Yeni şube sepete ekleniyor');
          await addNewBranchToBasket(
            state,
            basketDoc,
            event.totalPrice,
            event.productModel,
          );
        }
      } else {
        loggerPrint.printInfoLog('Sepet Henüz Açılmamış');

        await basketDoc.set({
          'id': FirebaseService().authID,
          'basket_status': BasketMainStatusControl.orderReceived.value,
        });

        await addNewBranchToBasket(
          state,
          basketDoc,
          event.totalPrice,
          event.productModel,
        );
      }
      if (!event.context.mounted) return;
      emit(
        ProductBasketAddSuccessState(
          AppLocalizations.of(event.context)!.products_basket_add_success,
        ),
      );
    } catch (e) {
      emit(
        ProductBasketAddError(
          AppLocalizations.of(event.context)!.products_basket_add_error,
        ),
      );
    }
  }

  Future<void> addNewBranchToBasket(
    ProductState state,
    DocumentReference basketDoc,
    int totalPrice,
    ProductModel productModel,
  ) async {
    await basketDoc
        .collection(FirebaseCollectionReferances.branch.name)
        .doc(productModel.storeId)
        .set({
      'id': productModel.storeId,
      'basket_total': totalPrice,
      'total_quanity': 1,
      'status': OrderBranchStatusControl.orderReceived.value,
    });

    await addNewProductToBasket(
      state,
      basketDoc,
      totalPrice,
      productModel,
      productModel.storeId,
    );
  }

  Future<void> addNewProductToBasket(
    ProductState state,
    DocumentReference basketDoc,
    int totalPrice,
    ProductModel productModel,
    String storeId,
  ) async {
    await basketDoc
        .collection(FirebaseCollectionReferances.branch.name)
        .doc(productModel.storeId)
        .collection(FirebaseCollectionReferances.product.name)
        .add({
      'id': null,
      'quanity': 1,
      'size': state.coffeSize.productTypeValue,
      'avaible': state.coffeeType.coffeAvaibleTypeValue,
      'status': OrderProductStatusControl.orderInProgress.value,
      'product_id': productModel.id,
      'product_total': totalPrice,
      'branch_id': storeId,
    }).then((value) {
      final docId = value.id;
      value.update({'id': docId});
      loggerPrint.printInfoLog('Yeni ürün sepete eklendi: $docId');
    });
  }
}
