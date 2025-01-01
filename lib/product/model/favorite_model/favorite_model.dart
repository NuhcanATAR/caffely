import 'package:caffely/product/model/timestamp_model/timestamp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'favorite_model.g.dart';

@JsonSerializable()
class FavoriteModel {
  final String id;
  final String productId;
  final String storeId;
  final String userId;
  @TimestampConverter()
  final Timestamp? date;

  FavoriteModel(
    this.id,
    this.productId,
    this.storeId,
    this.userId,
    this.date,
  );

  factory FavoriteModel.fromMap(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);
}
