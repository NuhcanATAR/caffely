import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PersonalInformationEvent extends Equatable {
  const PersonalInformationEvent();

  @override
  List<Object> get props => [];
}

class PersonalInformationUpdatedEvent extends PersonalInformationEvent {
  final String nameSurmame;
  final int phoneNumber;
  final String selectedCity;
  final String selectedDistrict;
  final BuildContext context;
  final UserModel userModel;

  const PersonalInformationUpdatedEvent(
    this.nameSurmame,
    this.phoneNumber,
    this.selectedCity,
    this.selectedDistrict,
    this.context,
    this.userModel,
  );
}
