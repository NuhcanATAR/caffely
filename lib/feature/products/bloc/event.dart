import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class ProductIncrementEvent extends ProductEvent {}

class ProductDecrementEvent extends ProductEvent {}

class LoadProducts extends ProductEvent {}

class ProductAvaibleEvent extends ProductEvent {
  final ProductCoffeAvaibleTypeControl isAvaible;

  const ProductAvaibleEvent(
    this.isAvaible,
  );

  @override
  List<Object> get props => [isAvaible];
}

class ProductCoffeSizeEvent extends ProductEvent {
  final ProductTypeControl isCoffeSize;

  const ProductCoffeSizeEvent(
    this.isCoffeSize,
  );

  @override
  List<Object> get props => [isCoffeSize];
}

class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object> get props => [query];
}

class ProductFavoriteCreateEvent extends ProductEvent {
  final String productId;
  final String favoriteId;
  final bool isFavoriteStatus;

  const ProductFavoriteCreateEvent(
    this.productId,
    this.favoriteId,
    this.isFavoriteStatus,
  );
}