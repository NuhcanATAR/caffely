import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String qrCodeId;
  final String profileImage;
  final String nameSurname;
  final String email;
  final int phoneNumber;
  final String city;
  final String district;
  final int authStatus;

  UserModel(
    this.id,
    this.qrCodeId,
    this.profileImage,
    this.nameSurname,
    this.email,
    this.phoneNumber,
    this.city,
    this.district,
    this.authStatus,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
