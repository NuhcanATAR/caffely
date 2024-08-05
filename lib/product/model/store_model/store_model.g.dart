// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      json['id'] as String,
      json['store_name'] as String,
      json['store_description'] as String,
      json['location_city'] as String,
      json['location_district'] as String,
      json['location_neighborhood'] as String,
      json['location_street'] as String,
      (json['phone_number'] as num).toInt(),
      json['email'] as String,
      json['cover_image'] as String,
      json['cover_second_image'] as String,
      json['cover_three_image'] as String,
      (json['min_basket_amount'] as num).toInt(),
      (json['delivery_time_frame'] as num).toInt(),
      json['free_delivery'] as bool,
      json['payment_types'] as String,
      json['trade_name'] as String,
      json['location_url'] as String,
      const TimestampConverter().fromJson(json['opening_time']),
      const TimestampConverter().fromJson(json['closing_time']),
      const TimestampConverter().fromJson(json['date']),
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_name': instance.storeName,
      'store_description': instance.storeDescription,
      'location_city': instance.locationCity,
      'location_district': instance.locationDistrict,
      'location_neighborhood': instance.locationNeighborhood,
      'location_street': instance.locationStreet,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'cover_image': instance.coverImage,
      'cover_second_image': instance.coverSeconImage,
      'cover_three_image': instance.coverThreeImage,
      'min_basket_amount': instance.minBasketAmount,
      'delivery_time_frame': instance.deliveryTimeFrame,
      'free_delivery': instance.freeDelivery,
      'payment_types': instance.paymentTypes,
      'trade_name': instance.tradeName,
      'location_url': instance.locationUrl,
      'opening_time': const TimestampConverter().toJson(instance.openingTime),
      'closing_time': const TimestampConverter().toJson(instance.closingTime),
      'date': const TimestampConverter().toJson(instance.date),
    };
