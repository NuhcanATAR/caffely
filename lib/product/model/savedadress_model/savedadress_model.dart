import 'package:cloud_firestore/cloud_firestore.dart';
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
  final Timestamp? createdDate;

  SavedAdressModel({
    this.id = '',
    this.userId = '',
    this.contactPhoneNumber = 0,
    this.adressTitle = '',
    this.adressCity = '',
    this.adressDistrict = '',
    this.adressStreet = '',
    this.adressFloor = 0,
    this.adressAparmentNo = 0,
    this.adressDirections = '',
    this.contactName = '',
    this.contactSurname = '',
    this.isDeleted = false,
    this.createdDate,
  });

  factory SavedAdressModel.fromJson(Map<String, dynamic> json) =>
      _$SavedAdressModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavedAdressModelToJson(this);

  Map<String, dynamic> toFirebaseAdd() {
    return {
      'id': null,
      'user_id': userId,
      'adress_title': adressTitle,
      'adress_city': adressCity,
      'adress_district': adressDistrict,
      'adress_street': adressStreet,
      'adress_floor': adressFloor,
      'adress_apartment_no': adressAparmentNo,
      'adress_directions': adressDirections,
      'contact_name': contactName,
      'contact_surname': contactSurname,
      'contact_phone_number': contactPhoneNumber,
      'is_deleted': isDeleted,
      'created_date': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toFirebaseDocUpdate() {
    return {
      'id': id,
    };
  }

  Map<String, dynamic> toFirebaseUpdate() {
    return {
      'adress_title': adressTitle,
      'adress_city': adressCity,
      'adress_district': adressDistrict,
      'adress_street': adressStreet,
      'adress_floor': adressFloor,
      'adress_apartment_no': adressAparmentNo,
      'adress_directions': adressDirections,
      'contact_name': contactName,
      'contact_surname': contactSurname,
      'contact_phone_number': contactPhoneNumber,
    };
  }

  Map<String, dynamic> toFirebaseDocDelete() {
    return {
      'is_deleted': isDeleted,
    };
  }
}
