import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:equatable/equatable.dart';

class BasketState extends Equatable {
  @override
  List<Object> get props => [];
}

class BasketInitialState extends BasketState {}

class BasketLoadingState extends BasketState {}

class BasketLoaded extends BasketState {
  final bool isBasket;
  final List<BasketBranchModel> branches;
  final bool isProductsVisible;

  BasketLoaded({
    bool? isBasket,
    List<BasketBranchModel>? branches,
    bool? isProductsVisible,
  })  : isBasket = isBasket ?? false,
        branches = branches ?? [],
        isProductsVisible = isProductsVisible ?? true;

  BasketLoaded copyWith({
    bool? isBasket,
    List<BasketBranchModel>? branches,
    bool? isProductsVisible,
  }) {
    return BasketLoaded(
      isBasket: isBasket ?? this.isBasket,
      branches: branches ?? this.branches,
      isProductsVisible: isProductsVisible ?? this.isProductsVisible,
    );
  }

  @override
  List<Object> get props => [isBasket, branches, isProductsVisible];
}

class BasketError extends BasketState {}

class BaskekOrderCompleteLoading extends BasketState {}

class BasketOrderCompleteState extends BasketState {
  final String message;

  BasketOrderCompleteState(this.message);
}

class BasketOrderCompleteError extends BasketState {
  final String message;

  BasketOrderCompleteError(this.message);
}
