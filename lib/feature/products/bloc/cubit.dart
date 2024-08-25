import 'package:caffely/feature/products/bloc/event.dart';
import 'package:caffely/feature/products/bloc/state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
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

      emit(
        ProductFavoriteAddSuccess(
          event.isFavoriteStatus
              ? 'Şube Favorilere eklendi!'
              : 'Şube Favorilerden kaldırıldı!',
        ),
      );
    } catch (e) {
      emit(
        const ProductFavoriteAddError(
          'Hata oluştu, lütfen daha sonra tekrar deneyiniz.',
        ),
      );
    }
  }
}
