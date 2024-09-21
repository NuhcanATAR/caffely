// ignore_for_file: always_declare_return_types, annotate_overrides

import 'package:caffely/product/model/centerhelp_model/centerhelp_model.dart';
import 'package:equatable/equatable.dart';

abstract class CenterHelpState extends Equatable {
  @override
  List<Object> get props => [];

  get centerHelps => null;
}

class CenterHelpInitial extends CenterHelpState {}

class CenterHelpLoading extends CenterHelpState {}

class CenterHelpLoadedState extends CenterHelpState {
  final List<CenterHelpModel> centerHelps;

  CenterHelpLoadedState(this.centerHelps);

  @override
  List<Object> get props => [centerHelps];
}

class CenterHelpError extends CenterHelpState {
  final String message;

  CenterHelpError(this.message);

  @override
  List<Object> get props => [message];
}
