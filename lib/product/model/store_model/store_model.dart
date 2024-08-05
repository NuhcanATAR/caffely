import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'store_model.g.dart';

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
class StoreModel {
  final String id;
  final String storeName;
  final String storeDescription;
  final String locationCity;
  final String locationDistrict;
  final String locationNeighborhood;
  final String locationStreet;
  final int phoneNumber;
  final String email;
  final String coverImage;
  final String coverSeconImage;
  final String coverThreeImage;
  final int minBasketAmount;
  final int deliveryTimeFrame;
  final bool freeDelivery;
  final String paymentTypes;
  final String tradeName;
  final String locationUrl;
  @TimestampConverter()
  final Timestamp? openingTime;
  @TimestampConverter()
  final Timestamp? closingTime;
  @TimestampConverter()
  final Timestamp? date;

  StoreModel(
    this.id,
    this.storeName,
    this.storeDescription,
    this.locationCity,
    this.locationDistrict,
    this.locationNeighborhood,
    this.locationStreet,
    this.phoneNumber,
    this.email,
    this.coverImage,
    this.coverSeconImage,
    this.coverThreeImage,
    this.minBasketAmount,
    this.deliveryTimeFrame,
    this.freeDelivery,
    this.paymentTypes,
    this.tradeName,
    this.locationUrl,
    this.openingTime,
    this.closingTime,
    this.date,
  );

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
