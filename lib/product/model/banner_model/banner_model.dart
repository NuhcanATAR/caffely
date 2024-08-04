import 'package:json_annotation/json_annotation.dart';
part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final String id;
  final String img;
  final String url;
  final bool isUrl;
  final bool status;
  final bool isDeleted;

  BannerModel(
    this.id,
    this.img,
    this.url,
    this.isUrl,
    this.status,
    this.isDeleted,
  );

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
