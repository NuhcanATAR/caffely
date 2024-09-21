import 'package:equatable/equatable.dart';

abstract class QrCodeEvent extends Equatable {
  const QrCodeEvent();

  @override
  List<Object> get props => [];
}

class QrCodeCreateEvent extends QrCodeEvent {}
