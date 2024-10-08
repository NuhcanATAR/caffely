import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/order_model/order_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  final List<BasketBranchModel> branches;
  final List<BasketProductModel> products;
  final int totalPrice;
  final int totalQuanity;

  OrderLoaded({
    List<OrderModel>? orders,
    List<BasketBranchModel>? branches,
    List<BasketProductModel>? products,
    int? totalPrice,
    int? totalQuanity,
  })  : orders = orders ?? [],
        branches = branches ?? [],
        products = products ?? [],
        totalPrice = totalPrice ?? 0,
        totalQuanity = totalQuanity ?? 0;

  OrderLoaded copyWith({
    List<OrderModel>? orders,
    List<BasketBranchModel>? branches,
    List<BasketProductModel>? products,
    int? totalPrice,
    int? totalQuanity,
  }) {
    return OrderLoaded(
      orders: orders ?? this.orders,
      branches: branches ?? this.branches,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      totalQuanity: totalQuanity ?? this.totalQuanity,
    );
  }

  @override
  List<Object> get props => [
        orders,
        branches,
        products,
        totalPrice,
        totalQuanity,
      ];
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);

  @override
  List<Object> get props => [message];
}
