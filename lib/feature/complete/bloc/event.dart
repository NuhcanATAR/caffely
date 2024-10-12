import 'package:caffely/product/extension/dynamic_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProfileCompleteEvent extends Equatable {
  const ProfileCompleteEvent();

  @override
  List<Object> get props => [];
}

class ProfileCompleteNameSurnameEvent extends ProfileCompleteEvent {
  final String nameSurname;

  const ProfileCompleteNameSurnameEvent(this.nameSurname);
}

class ProfileCompletePhoneNumberEvent extends ProfileCompleteEvent {
  final String phoneNumber;

  const ProfileCompletePhoneNumberEvent(this.phoneNumber);
}

class ProfileCompleteUser extends ProfileCompleteEvent {
  final String nameSurname;
  final int phoneNumber;
  final String city;
  final String district;
  final DynamicViewExtensions dynamicViewExtensions;
  final BuildContext context;

  const ProfileCompleteUser(
    this.nameSurname,
    this.phoneNumber,
    this.city,
    this.district,
    this.dynamicViewExtensions,
    this.context,
  );
}
