import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class QrCodeEvent extends Equatable {
  const QrCodeEvent();

  @override
  List<Object> get props => [];
}

class QrCodeCreateEvent extends QrCodeEvent {
  final BuildContext context;

  const QrCodeCreateEvent(this.context);
}
