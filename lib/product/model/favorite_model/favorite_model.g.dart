// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) =>
    FavoriteModel(
      json['id'] as String,
      json['product_id'] as String,
      json['store_id'] as String,
      json['user_id'] as String,
      const TimestampConverter().fromJson(json['date']),
    );

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'store_id': instance.storeId,
      'user_id': instance.userId,
      'date': const TimestampConverter().toJson(instance.date),
    };
