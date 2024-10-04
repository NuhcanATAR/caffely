import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:equatable/equatable.dart';

class SavedAdressState extends Equatable {
  final String adressTitle;
  final String adressCity;
  final String adressDistrict;
  final String adressStreet;
  final String adressFloor;
  final String adressAparmentNo;
  final String adressDirections;
  final String contactName;
  final String contactSurname;
  final String contactPhoneNumber;

  const SavedAdressState({
    this.adressTitle = '',
    this.adressCity = '',
    this.adressDistrict = '',
    this.adressStreet = '',
    this.adressFloor = '',
    this.adressAparmentNo = '',
    this.adressDirections = '',
    this.contactName = '',
    this.contactSurname = '',
    this.contactPhoneNumber = '',
  });

  SavedAdressState copyWith({
    String? adressTitle,
    String? adressCity,
    String? adressDistrict,
    String? adressStreet,
    String? adressFloor,
    String? adressAparmentNo,
    String? adressDirections,
    String? contactName,
    String? contactSurname,
    String? contactPhoneNumber,
  }) {
    return SavedAdressState(
      adressTitle: adressTitle ?? this.adressTitle,
      adressCity: adressCity ?? this.adressCity,
      adressDistrict: adressDistrict ?? this.adressDistrict,
      adressStreet: adressStreet ?? this.adressStreet,
      adressFloor: adressFloor ?? this.adressFloor,
      adressAparmentNo: adressAparmentNo ?? this.adressAparmentNo,
      adressDirections: adressDirections ?? this.adressDirections,
      contactName: contactName ?? this.contactName,
      contactSurname: contactSurname ?? this.contactSurname,
      contactPhoneNumber: contactPhoneNumber ?? this.contactPhoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        adressTitle,
        adressCity,
        adressDistrict,
        adressStreet,
        adressFloor,
        adressAparmentNo,
        adressDirections,
        contactName,
        contactSurname,
        contactPhoneNumber,
      ];
}

class SaveAdressCreateLoading extends SavedAdressState {}

class SaveAdressCreateSuccess extends SavedAdressState {
  final String message;

  const SaveAdressCreateSuccess(this.message);
}

class SaveAdressCreateError extends SavedAdressState {
  final String errorMessage;

  const SaveAdressCreateError(this.errorMessage);
}

class SaveAdressDeleteSuccess extends SavedAdressState {
  final String message;

  const SaveAdressDeleteSuccess(this.message);
}

class SaveAdressDeleteError extends SavedAdressState {
  final String errorMessage;

  const SaveAdressDeleteError(this.errorMessage);
}

class SaveAdressUpdateLoading extends SavedAdressState {}

class SaveAdressUpdateSuccess extends SavedAdressState {
  final String message;

  const SaveAdressUpdateSuccess(this.message);
}

class SaveAdressUpdateError extends SavedAdressState {
  final String errorMessage;

  const SaveAdressUpdateError(this.errorMessage);
}

class SavedAdressInitial extends SavedAdressState {}

class SavedAdressLoading extends SavedAdressState {}

class SavedAdressLoaded extends SavedAdressState {
  final List<SavedAdressModel> savedAdress;

  const SavedAdressLoaded(this.savedAdress);
}

class SavedAdressError extends SavedAdressState {
  final String errorMessage;

  const SavedAdressError(this.errorMessage);
}
