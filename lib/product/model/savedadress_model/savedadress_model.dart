import 'package:json_annotation/json_annotation.dart';

part 'savedadress_model.g.dart';

@JsonSerializable()
class SavedAdressModel {
  final String id;
  final String userId;
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
  final bool isDeleted;

  SavedAdressModel(
    this.id,
    this.userId,
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
    this.isDeleted,
  );

  factory SavedAdressModel.fromJson(Map<String, dynamic> json) =>
      _$SavedAdressModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedAdressModelToJson(this);
}
