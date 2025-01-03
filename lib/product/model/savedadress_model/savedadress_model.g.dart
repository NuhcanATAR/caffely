part of 'savedadress_model.dart';

SavedAdressModel _$SavedAdressModelFromJson(Map<String, dynamic> json) {
  return SavedAdressModel(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    adressTitle: json['adress_title'] as String,
    adressCity: json['adress_city'] as String,
    adressDistrict: json['adress_district'] as String,
    adressStreet: json['adress_street'] as String,
    adressFloor: json['adress_floor'] as int,
    adressAparmentNo: json['adress_apartment_no'] as int,
    adressDirections: json['adress_directions'] as String,
    contactName: json['contact_name'] as String,
    contactSurname: json['contact_surname'] as String,
    contactPhoneNumber: json['contact_phone_number'] as int,
    isDeleted: json['is_deleted'] as bool,
    createdDate: json['created_date'] as Timestamp,
  );
}

Map<String, dynamic> _$SavedAdressModelToJson(SavedAdressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'adress_title': instance.adressTitle,
      'adress_city': instance.adressCity,
      'adress_district': instance.adressDistrict,
      'adress_street': instance.adressStreet,
      'adress_floor': instance.adressFloor,
      'adress_apartment_no': instance.adressAparmentNo,
      'adress_directions': instance.adressDirections,
      'contact_name': instance.contactName,
      'contact_surname': instance.contactSurname,
      'contact_phone_number': instance.contactPhoneNumber,
      'is_deleted': instance.isDeleted,
      'created_date': instance.createdDate,
    };
