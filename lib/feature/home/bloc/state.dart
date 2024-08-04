import 'package:caffely/product/model/banner_model/banner_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeBannerLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<BannerModel> banners;
  final List<StoreModel> stores;
  final List<ProductModel> products;

  HomeLoaded(
    this.banners,
    this.stores,
    this.products,
  );

  @override
  List<Object> get props => [
        banners,
        stores,
        products,
      ];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object> get props => [message];
}
