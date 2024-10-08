import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_model.g.dart';

class TimestampConverter implements JsonConverter<Timestamp?, Object?> {
  const TimestampConverter();

  @override
  Timestamp? fromJson(Object? json) {
    if (json is Timestamp) {
      return json;
    } else if (json is int) {
      return Timestamp.fromMillisecondsSinceEpoch(json);
    } else if (json is Map<String, dynamic>) {
      if (json.containsKey('_seconds') && json.containsKey('_nanoseconds')) {
        final int seconds = json['_seconds'];
        final int nanoseconds = json['_nanoseconds'];
        return Timestamp(seconds, nanoseconds);
      }
    }
    return null;
  }

  @override
  Object? toJson(Timestamp? object) {
    if (object == null) return null;
    return {
      '_seconds': object.seconds,
      '_nanoseconds': object.nanoseconds,
    };
  }
}

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

  OrderModel(
    this.id,
    this.adressApartmentNo,
    this.adressCity,
    this.adressDirections,
    this.adressDistrict,
    this.adressFloor,
    this.adressStreet,
    this.adressTitle,
    this.contactName,
    this.contactSurname,
    this.contactPhoneNumber,
    this.paymentType,
    this.userId,
    this.date,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
