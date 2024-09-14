import 'package:equatable/equatable.dart';

class PersonalInformationState extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonalInformationUpdateLoading extends PersonalInformationState {}

class PersonalInformationUpdateSuccess extends PersonalInformationState {
  final String message;

  PersonalInformationUpdateSuccess(this.message);
}

class PersonalInformationUpdateError extends PersonalInformationState {
  final String error;

  PersonalInformationUpdateError(this.error);
}
