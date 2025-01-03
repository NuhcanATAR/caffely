import 'package:json_annotation/json_annotation.dart';

part 'qrcode_model.g.dart';

@JsonSerializable()
class QrCodeModel {
  final String id;
  @JsonKey(name: 'qrcode_url')
  final String qrCode;

  QrCodeModel({
    this.id = '',
    this.qrCode = '',
  });

  factory QrCodeModel.fromJson(Map<String, dynamic> json) =>
      _$QrCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$QrCodeModelToJson(this);
}
