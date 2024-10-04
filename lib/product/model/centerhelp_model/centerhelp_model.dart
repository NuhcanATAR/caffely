import 'package:json_annotation/json_annotation.dart';
part 'centerhelp_model.g.dart';

@JsonSerializable()
class CenterHelpModel {
  final String id;
  final String title;
  final String explanation;
  final bool isDeleted;

  CenterHelpModel(
    this.id,
    this.title,
    this.explanation,
    this.isDeleted,
  );

  factory CenterHelpModel.fromJson(Map<String, dynamic> json) =>
      _$CenterHelpModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterHelpModelToJson(this);
}
