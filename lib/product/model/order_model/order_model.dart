import 'package:caffely/product/model/timestamp_model/timestamp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String id;
  final int adressApartmentNo;
  final String adressCity;
  final String adressDirections;
  final String adressDistrict;
  final int adressFloor;
  final String adressStreet;
  final String adressTitle;
  final String contactName;
  final String contactSurname;
  final int contactPhoneNumber;
  final int paymentType;
  final String userId;
  @TimestampConverter()
  final Timestamp? date;

  OrderModel({
    this.id = '',
    this.adressApartmentNo = 0,
    this.adressCity = '',
    this.adressDirections = '',
    this.adressDistrict = '',
    this.adressFloor = 0,
    this.adressStreet = '',
    this.adressTitle = '',
    this.contactName = '',
    this.contactSurname = '',
    this.contactPhoneNumber = 0,
    this.paymentType = 0,
    this.userId = '',
    this.date,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  Map<String, dynamic> toOrderAdd() {
    return {
      'id': id,
      'user_id': userId,
      'payment_type': paymentType,
      'adress_title': adressTitle,
      'adress_city': adressCity,
      'adress_district': adressDistrict,
      'adress_street': adressStreet,
      'adress_floor': adressFloor,
      'adress_apartment_no': adressApartmentNo,
      'adress_directions': adressDirections,
      'contact_name': contactName,
      'contact_surname': contactSurname,
      'contact_phone_number': contactPhoneNumber,
      'date': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toOrderDocUpdate() {
    return {
      'id': id,
    };
  }
}
