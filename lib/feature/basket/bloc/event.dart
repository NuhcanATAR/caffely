import 'package:caffely/feature/basket/view/order_complete/order_complete_viewmodel.dart';
import 'package:caffely/product/model/basket_branch_model/basket_branch_model.dart';
import 'package:caffely/product/model/basket_product_model/basket_product_model.dart';
import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BasketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBasketEvent extends BasketEvent {}

class BasketOrderCreateEvent extends BasketEvent {
  final SavedAdressModel selectAdress;
  final PaymentType paymentType;
  final List<BasketBranchModel> basketBranchModel;
  final List<BasketProductModel> basketProductModel;
  final BuildContext context;

  BasketOrderCreateEvent(
    this.selectAdress,
    this.paymentType,
    this.basketBranchModel,
    this.basketProductModel,
    this.context,
  );
}
