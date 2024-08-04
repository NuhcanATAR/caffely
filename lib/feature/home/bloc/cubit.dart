import 'package:caffely/feature/home/bloc/event.dart';
import 'package:caffely/feature/home/bloc/state.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/model/banner_model/banner_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHome>(_onLoadBanners);
  }

  Future<void> _onLoadBanners(
    LoadHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeBannerLoading());
    try {
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .banners.collectRef
          .where('is_deleted', isEqualTo: false)
          .where('status', isEqualTo: false)
          .get();
      final List<BannerModel> banners = snapshot.docs
          .map(
            (doc) => BannerModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      final QuerySnapshot snapshotStore = await FirebaseCollectionReferances
          .stores.collectRef
          .where('is_deleted', isEqualTo: false)
          .get();
      final List<StoreModel> stores = snapshotStore.docs
          .map(
            (doc) => StoreModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      final QuerySnapshot snapshotProduct = await FirebaseCollectionReferances
          .product.collectRef
          .where('is_deleted', isEqualTo: false)
          .where('is_showcase', isEqualTo: true)
          .get();
      final List<ProductModel> products = snapshotProduct.docs
          .map(
            (doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
      emit(
        HomeLoaded(
          banners,
          stores,
          products,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
