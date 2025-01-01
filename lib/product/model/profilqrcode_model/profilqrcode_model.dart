import 'package:caffely/product/model/timestamp_model/timestamp_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profilqrcode_model.g.dart';

@JsonSerializable()
class ProfileQRCodeModel {
  final String id;
  final String userId;
  final String qrCode;
  @TimestampConverter()
  final Timestamp? date;
  final bool isDeleted;

  ProfileQRCodeModel(
    this.id,
    this.userId,
    this.qrCode,
    this.date,
    this.isDeleted,
  );

  factory ProfileQRCodeModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileQRCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileQRCodeModelToJson(this);
}
