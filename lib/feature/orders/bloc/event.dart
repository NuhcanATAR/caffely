import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadOrderEvent extends OrderEvent {
  final BuildContext context;

  LoadOrderEvent(this.context);
}

class LoadBranchesEvent extends OrderEvent {
  final String orderId;
  final BuildContext context;

  LoadBranchesEvent(
    this.orderId,
    this.context,
  );

  @override
  List<Object> get props => [orderId];
}
