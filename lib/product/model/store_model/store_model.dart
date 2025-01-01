import 'package:caffely/product/model/timestamp_model/timestamp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'store_model.g.dart';

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
  final bool isDeleted;
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
    this.isDeleted,
    this.openingTime,
    this.closingTime,
    this.date,
  );

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
