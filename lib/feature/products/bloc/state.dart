import 'package:caffely/product/core/base/helper/producttype_control.dart';
import 'package:caffely/product/model/favorite_model/favorite_model.dart';
import 'package:caffely/product/model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final ProductCoffeAvaibleTypeControl coffeeType;
  final ProductTypeControl coffeSize;
  final String productId;

  const ProductState({
    this.coffeeType = ProductCoffeAvaibleTypeControl.notSelect,
    this.coffeSize = ProductTypeControl.notSelect,
    this.productId = "",
  });

  ProductState copytWith({
    ProductCoffeAvaibleTypeControl? coffeeType,
    ProductTypeControl? coffeSize,
    String? productId,
  }) {
    return ProductState(
      coffeeType: coffeeType ?? this.coffeeType,
      coffeSize: coffeSize ?? this.coffeSize,
      productId: productId ?? this.productId,
    );
  }

  @override
  List<Object> get props => [coffeeType, coffeSize, productId];
}

class ProductInitialState extends ProductState {
  const ProductInitialState()
      : super(
          coffeeType: ProductCoffeAvaibleTypeControl.notSelect,
          coffeSize: ProductTypeControl.notSelect,
        );
}

class ProductUpdatedState extends ProductState {
  const ProductUpdatedState(
    ProductCoffeAvaibleTypeControl coffeeType,
    ProductTypeControl coffeSize,
  ) : super(coffeeType: coffeeType, coffeSize: coffeSize);
}

class ProductsLoading extends ProductState {}

class ProductFavoriteAddLoading extends ProductState {}

class ProductFavoriteAddSuccess extends ProductState {
  final String message;

  const ProductFavoriteAddSuccess(this.message);
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final List<FavoriteModel> favorites;

  const ProductLoaded(
    this.products,
    this.favorites,
  );

  @override
  List<Object> get props => [products, favorites];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductFavoriteAddError extends ProductState {
  final String message;

  const ProductFavoriteAddError(this.message);
}

class ProductBasketAddSuccessState extends ProductState {
  final String message;

  const ProductBasketAddSuccessState(this.message);
}

class ProductBasketAddError extends ProductState {
  final String message;

  const ProductBasketAddError(this.message);
}
