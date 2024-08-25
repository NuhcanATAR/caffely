import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductModel> products;
  final List<StoreModel> stores;

  FavoriteLoaded(
    this.products,
    this.stores,
  );

  @override
  List<Object> get props => [
        products,
        stores,
      ];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String errorMessage;

  FavoriteError(
    this.errorMessage,
  );

  @override
  List<Object> get props => [errorMessage];
}
