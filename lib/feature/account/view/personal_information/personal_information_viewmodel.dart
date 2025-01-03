import 'package:caffely/feature/account/view/personal_information/bloc/mixin.dart';
import 'package:caffely/feature/account/view/personal_information/personal_information_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/model/user_model/user_model.dart';
import 'package:flutter/material.dart';

abstract class PersonalInformationViewModel
    extends BaseState<PersonalInformationView> with PersonalInformationMixin {
  final formPersonalInformationKey = GlobalKey<FormState>();

  late final TextEditingController nameSurnameController;

  late final TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    nameSurnameController = TextEditingController();
    phoneNumberController = TextEditingController();
    selectedCity = null;
    selectedDistrict = null;
  }

  @override
  void dispose() {
    super.dispose();
    nameSurnameController.dispose();
    phoneNumberController.dispose();
  }

  void initializeControllers(UserModel userModel) {
    nameSurnameController.text = userModel.nameSurname;
    phoneNumberController.text = userModel.phoneNumber.toString();
    selectedCity = userModel.city;
    selectedDistrict = userModel.district;
  }

  // city distirct
  String? selectedCity;
  String? selectedDistrict;

  void handleCityChanged(String? city) {
    setState(() {
      selectedCity = city;
      selectedDistrict = null;
    });
  }

  void handleDistrictChanged(String? district) {
    setState(() {
      selectedDistrict = district;
    });
  }
}
