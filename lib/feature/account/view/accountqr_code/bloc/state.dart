import 'package:equatable/equatable.dart';

class QrCodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class QrCodeLoadingState extends QrCodeState {}

class QrCodeCreateSuccessState extends QrCodeState {
  final String message;

  QrCodeCreateSuccessState(this.message);
}

class QrCodeCreateErrorState extends QrCodeState {
  final String error;

  QrCodeCreateErrorState(this.error);
}

class QrCodeExistState extends QrCodeState {
  final String qrCodeUrl;

  QrCodeExistState(this.qrCodeUrl);
}

class QrCodeNotExistState extends QrCodeState {
  final String title;
  final String subTitle;

  QrCodeNotExistState(this.title, this.subTitle);
}

class QrCodeErrorState extends QrCodeState {
  final String title;
  final String subTitle;

  QrCodeErrorState(this.title, this.subTitle);
}

class QrCodeInitialState extends QrCodeState {}
