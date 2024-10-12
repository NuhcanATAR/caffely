import 'package:caffely/feature/store/bloc/event.dart';
import 'package:caffely/feature/store/bloc/state.dart';
import 'package:caffely/lang/app_localizations.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/favorite_model/favorite_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreBloc extends Bloc<StoresEvent, StoresState> {
  List<StoreModel> allStores = [];
  List<ProductModel> productList = [];
  List<FavoriteModel> favoritesList = [];
  StoreBloc() : super(StoresInitial()) {
    on<LoadStores>(_onLoadStores);
    on<SearchStores>(_onSearchStores);
    on<LoadStoreDetail>(_onLoadProducts);
    on<StoreFavoriteCreateEvent>(storeFavoriteAdd);
  }

  Future<void> _onLoadStores(
    LoadStores event,
    Emitter<StoresState> emit,
  ) async {
    emit(StoresLoading());
    try {
      final userCollection = await FirebaseCollectionReferances.users.collectRef
          .doc(FirebaseService().authID)
          .get();
      final userCity = userCollection['city'];
      final QuerySnapshot snapshotStore = await FirebaseCollectionReferances
          .stores.collectRef
          .where('location_city', isEqualTo: userCity)
          .where('is_deleted', isEqualTo: false)
          .get();
      allStores = snapshotStore.docs
          .map(
            (doc) => StoreModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
      emit(
        StoresLoaded(
          allStores,
        ),
      );
    } catch (e) {
      emit(StoresError(e.toString()));
    }
  }

  Future<void> _onSearchStores(
    SearchStores event,
    Emitter<StoresState> emit,
  ) async {
    emit(StoresLoading());
    try {
      final List<StoreModel> filteredStores = allStores.where((store) {
        final storeNameLower = store.storeName.toLowerCase();
        final queryLower = event.query.toLowerCase();
        return storeNameLower.contains(queryLower);
      }).toList();
      emit(
        StoresLoaded(
          filteredStores,
        ),
      );
    } catch (e) {
      emit(StoresError(e.toString()));
    }
  }

  Future<void> _onLoadProducts(
    LoadStoreDetail event,
    Emitter<StoresState> emit,
  ) async {
    emit(StoresLoading());
    try {
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .product.collectRef
          .where('store_id', isEqualTo: event.storeId)
          .where('is_deleted', isEqualTo: false)
          .get();
      productList = snapshot.docs
          .map(
            (doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      final QuerySnapshot snapshotFavorite = await FirebaseCollectionReferances
          .favorite.collectRef
          .where('store_id', isEqualTo: event.storeId)
          .where('user_id', isEqualTo: FirebaseService().authID)
          .get();
      favoritesList = snapshotFavorite.docs
          .map(
            (doc) => FavoriteModel.fromMap(doc.data() as Map<String, dynamic>),
          )
          .toList();
      emit(StoreDetailLoaded(productList, favoritesList));
    } catch (e) {
      emit(StoresError(e.toString()));
    }
  }

  Future<void> storeFavoriteAdd(
    StoreFavoriteCreateEvent event,
    Emitter<StoresState> emit,
  ) async {
    emit(StoreFavoriteAddLoading());
    try {
      event.isFavoriteStatus == true
          ? await FirebaseCollectionReferances.favorite.collectRef.add({
              'id': null,
              'product_id': '',
              'store_id': event.storeId,
              'user_id': FirebaseService().authID,
              'date': FieldValue.serverTimestamp(),
            }).then((value) {
              final String docId = value.id;
              value.update({'id': docId});
            })
          : await FirebaseCollectionReferances.favorite.collectRef
              .doc(event.favoriteId)
              .delete();
      if (!event.context.mounted) return;
      emit(
        StoreFavoriteAddSuccess(
          event.isFavoriteStatus == true
              ? AppLocalizations.of(event.context)!
                  .stores_information_favorite_add_success
              : AppLocalizations.of(event.context)!
                  .stores_information_favorite_delete_success,
        ),
      );
    } catch (e) {
      emit(
        StoreFavoriteAddError(
          AppLocalizations.of(event.context)!
              .stores_information_favorite_loading_title,
        ),
      );
    }
  }
}
