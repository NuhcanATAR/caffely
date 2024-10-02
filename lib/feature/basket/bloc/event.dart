import 'package:equatable/equatable.dart';

abstract class BasketEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBasketEvent extends BasketEvent {}
