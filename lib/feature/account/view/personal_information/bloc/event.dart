import 'package:equatable/equatable.dart';

abstract class PersonalInformationEvent extends Equatable {
  const PersonalInformationEvent();

  @override
  List<Object> get props => [];
}

class PersonalInformationUpdatedEvent extends PersonalInformationEvent {
  final String nameSurmame;
  final int phoneNumber;
  final String selectedCity;
  final String selectedDistrict;

  const PersonalInformationUpdatedEvent(
    this.nameSurmame,
    this.phoneNumber,
    this.selectedCity,
    this.selectedDistrict,
  );
}
