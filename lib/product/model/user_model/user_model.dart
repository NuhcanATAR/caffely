import 'package:cloud_firestore/cloud_firestore.dart';
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

  UserModel({
    this.id = '',
    this.qrCodeId = '',
    this.profileImage = '',
    this.nameSurname = '',
    this.email = '',
    this.phoneNumber = 0,
    this.city = '',
    this.district = '',
    this.authStatus = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Map<String, dynamic> toUpdateFiebaseMap() {
    return {
      'name_surname': nameSurname,
      'phone_number': phoneNumber,
      'city': city,
      'district': district,
    };
  }

  Map<String, dynamic> toUpdateQrCode(String authId) {
    return {
      'qrcode_id': authId,
    };
  }

  Map<String, dynamic> toUserInformationSet({String password = ''}) {
    return {
      'id': id,
      'profile_image': profileImage,
      'name_surname': nameSurname,
      'email': email,
      'password': password == '' ? '' : password,
      'phone_number': phoneNumber,
      'city': city,
      'district': district,
      'auth_status': authStatus,
      'date': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toUserUpdate() {
    return {
      'profile_image': profileImage,
      'auth_status': authStatus,
    };
  }
}
