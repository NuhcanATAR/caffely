import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadOrderEvent extends OrderEvent {}

class LoadBranchesEvent extends OrderEvent {
  final String orderId;

  LoadBranchesEvent(this.orderId);

  @override
  List<Object> get props => [orderId];
}
