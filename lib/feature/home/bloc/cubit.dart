import 'package:caffely/feature/home/bloc/event.dart';
import 'package:caffely/feature/home/bloc/state.dart';
import 'package:caffely/product/core/base/helper/logger.dart';
import 'package:caffely/product/core/database/firebase_constant.dart';
import 'package:caffely/product/core/database/firebase_database.dart';
import 'package:caffely/product/core/service/firebase/firebase_service.dart';
import 'package:caffely/product/model/banner_model/banner_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final loggerPrint = CustomLoggerPrint();
  HomeBloc() : super(HomeInitial()) {
    on<LoadHome>(_onLoadAll);
  }

  Future<void> _onLoadAll(
    LoadHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeBannerLoading());
    try {
      final QuerySnapshot snapshot = await FirebaseCollectionReferances
          .banners.collectRef
          .where(FirebaseConstant.isDeleted, isEqualTo: false)
          .where(FirebaseConstant.status, isEqualTo: false)
          .get();
      final List<BannerModel> banners = snapshot.docs
          .map(
            (doc) => BannerModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      final userCollection = await FirebaseCollectionReferances.users.collectRef
          .doc(FirebaseService().authID)
          .get();
      final userCity = userCollection['city'];
      final QuerySnapshot snapshotStore = await FirebaseCollectionReferances
          .stores.collectRef
          .where(FirebaseConstant.locationCity, isEqualTo: userCity)
          .where(FirebaseConstant.isDeleted, isEqualTo: false)
          .get();
      final List<StoreModel> stores = snapshotStore.docs
          .map(
            (doc) => StoreModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      final QuerySnapshot snapshotProduct = await FirebaseCollectionReferances
          .product.collectRef
          .where(FirebaseConstant.isDeleted, isEqualTo: false)
          .where(FirebaseConstant.isShowCase, isEqualTo: true)
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
      loggerPrint.printErrorLog(e.toString());
    }
  }
}
