import 'package:caffely/product/model/favorite_model/favorite_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:caffely/product/model/store_model/store_model.dart';
import 'package:equatable/equatable.dart';

class StoresState extends Equatable {
  final String storeId;

  const StoresState({
    this.storeId = "",
  });

  StoresState copyWith({
    String? storeId,
  }) {
    return StoresState(
      storeId: storeId ?? this.storeId,
    );
  }

  @override
  List<Object> get props => [storeId];
}

class StoresInitial extends StoresState {}

class StoresLoading extends StoresState {}

class ProductsLoading extends StoresState {}

class StoreFavoriteAddLoading extends StoresState {}

class StoresLoaded extends StoresState {
  final List<StoreModel> stores;

  const StoresLoaded(this.stores);

  @override
  List<Object> get props => [stores];
}

class StoreDetailLoaded extends StoresState {
  final List<ProductModel> products;
  final List<FavoriteModel> favorites;

  const StoreDetailLoaded(
    this.products,
    this.favorites,
  );
}

class StoreFavoriteAddSuccess extends StoresState {
  final String message;

  const StoreFavoriteAddSuccess(this.message);
}

class StoresError extends StoresState {
  final String message;

  const StoresError(this.message);

  @override
  List<Object> get props => [message];
}

class StoreDetailError extends StoresState {
  final String message;
  const StoreDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class StoreFavoriteAddError extends StoresState {
  final String message;

  const StoreFavoriteAddError(this.message);
}
