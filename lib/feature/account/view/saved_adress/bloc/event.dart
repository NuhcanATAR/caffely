import 'package:caffely/product/model/savedadress_model/savedadress_model.dart';
import 'package:equatable/equatable.dart';

abstract class SavedAdressEvent extends Equatable {
  const SavedAdressEvent();

  @override
  List<Object> get props => [];
}

class SavedAdressTitleEvent extends SavedAdressEvent {
  final String title;

  const SavedAdressTitleEvent(this.title);

  @override
  List<Object> get props => [title];
}

class SavedAdressCityEvent extends SavedAdressEvent {
  final String city;

  const SavedAdressCityEvent(this.city);

  @override
  List<Object> get props => [city];
}

class SavedAdressDistrictEvent extends SavedAdressEvent {
  final String district;

  const SavedAdressDistrictEvent(this.district);

  @override
  List<Object> get props => [district];
}

class SavedAdressStreetEvent extends SavedAdressEvent {
  final String street;

  const SavedAdressStreetEvent(this.street);

  @override
  List<Object> get props => [street];
}

class SavedAdressFloorEvent extends SavedAdressEvent {
  final String floor;

  const SavedAdressFloorEvent(this.floor);

  @override
  List<Object> get props => [floor];
}

class SavedAdressApartmentNoEvent extends SavedAdressEvent {
  final String apartmentNo;

  const SavedAdressApartmentNoEvent(this.apartmentNo);

  @override
  List<Object> get props => [apartmentNo];
}

class SavedAdressDirectionsEvent extends SavedAdressEvent {
  final String directions;

  const SavedAdressDirectionsEvent(this.directions);

  @override
  List<Object> get props => [directions];
}

class SavedAdressContactNameEvent extends SavedAdressEvent {
  final String contactName;

  const SavedAdressContactNameEvent(this.contactName);

  @override
  List<Object> get props => [contactName];
}

class SavedAdressContactSurnameEvent extends SavedAdressEvent {
  final String contactSurname;

  const SavedAdressContactSurnameEvent(this.contactSurname);

  @override
  List<Object> get props => [contactSurname];
}

class SavedAdressContactPhoneNumberEvent extends SavedAdressEvent {
  final String contactPhoneNumber;

  const SavedAdressContactPhoneNumberEvent(this.contactPhoneNumber);

  @override
  List<Object> get props => [contactPhoneNumber];
}

class SaveAdressCreateEvent extends SavedAdressEvent {
  final String adressTitle;
  final String adressCity;
  final String adressDistrict;
  final String adressStreet;
  final int adressFloor;
  final int adressAparmentNo;
  final String adressDirections;
  final String contactName;
  final String contactSurname;
  final int contactPhoneNumber;

  const SaveAdressCreateEvent(
    this.adressTitle,
    this.adressCity,
    this.adressDistrict,
    this.adressStreet,
    this.adressFloor,
    this.adressAparmentNo,
    this.adressDirections,
    this.contactName,
    this.contactSurname,
    this.contactPhoneNumber,
  );
}

class SaveAdressDeleteEvent extends SavedAdressEvent {
  final SavedAdressModel model;

  const SaveAdressDeleteEvent(this.model);
}

class SaveAdressEditEvent extends SavedAdressEvent {
  final SavedAdressModel model;
  final String adressTitle;
  final String adressCity;
  final String adressDistrict;
  final String adressStreet;
  final int adressFloor;
  final int adressAparmentNo;
  final String adressDirections;
  final String contactName;
  final String contactSurname;
  final int contactPhoneNumber;

  const SaveAdressEditEvent(
    this.model,
    this.adressTitle,
    this.adressCity,
    this.adressDistrict,
    this.adressStreet,
    this.adressFloor,
    this.adressAparmentNo,
    this.adressDirections,
    this.contactName,
    this.contactSurname,
    this.contactPhoneNumber,
  );
}

class LoadSavedAdressEvent extends SavedAdressEvent {}
