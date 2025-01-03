import 'package:caffely/feature/favorite/bloc/event.dart';
import 'package:caffely/feature/favorite/bloc/state.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/database/firebase_constant.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/favorite_model/favorite_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final loggerPrint = CustomLoggerPrint();
  FavoriteBloc() : super(FavoriteInitialState()) {
    on<LoadFavoriteProduct>(_onLoadFavorite);
  }

  Future<void> _onLoadFavorite(
    LoadFavoriteProduct event,
    Emitter<FavoriteState> emit,
  ) async {
    emit(FavoriteLoading());
    try {
      final List<ProductModel> allProducts = [];
      final List<StoreModel> allStores = [];
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .favorite.collectRef
          .where(FirebaseConstant.userId, isEqualTo: FirebaseService().authID)
          .get();

      final List<FavoriteModel> favorites = snapshot.docs
          .map(
            (doc) => FavoriteModel.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList();

      for (final FavoriteModel favorite in favorites) {
        if (favorite.productId.isNotEmpty) {
          final DocumentSnapshot productSnapshot =
              await FirebaseCollectionReferances.product.collectRef
                  .doc(favorite.productId)
                  .get();

          if (productSnapshot.exists) {
            final product = ProductModel.fromJson(
              productSnapshot.data() as Map<String, dynamic>,
            );

            if (!product.isDeleted) {
              allProducts.add(product);
            }
          }
        }

        if (favorite.storeId.isNotEmpty) {
          final DocumentSnapshot storeSnapshot =
              await FirebaseCollectionReferances.stores.collectRef
                  .doc(favorite.storeId)
                  .get();

          if (storeSnapshot.exists) {
            final store = StoreModel.fromJson(
              storeSnapshot.data() as Map<String, dynamic>,
            );

            if (!store.isDeleted) {
              allStores.add(store);
            }
          }
        }
      }

      emit(
        FavoriteLoaded(
          allProducts,
          allStores,
        ),
      );
    } catch (e) {
      emit(FavoriteError(e.toString()));
      loggerPrint.printErrorLog(e.toString());
    }
  }
}
