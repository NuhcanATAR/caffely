import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:equatable/equatable.dart';

class ProfileCompleteState extends Equatable {
  final String nameSurname;
  final String phoneNumber;
  final String city;
  final String district;

  const ProfileCompleteState({
    this.nameSurname = '',
    this.phoneNumber = '',
    this.city = '',
    this.district = '',
  });

  ProfileCompleteState copyWith({
    String? nameSurname,
    String? phoneNumber,
    String? city,
    String? district,
  }) {
    return ProfileCompleteState(
      nameSurname: nameSurname ?? this.nameSurname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }

  @override
  List<Object> get props => [
        nameSurname,
        phoneNumber,
        city,
        district,
      ];
}

class ProfileCompleteLoading extends ProfileCompleteState {
  final DynamicViewExtensions dynamicViewExtensions;

  const ProfileCompleteLoading(this.dynamicViewExtensions);
}

class ProfileCompleteSuccess extends ProfileCompleteState {}

class ProfileCompleteError extends ProfileCompleteState {
  final String errorMessage;

  const ProfileCompleteError(this.errorMessage);
}
