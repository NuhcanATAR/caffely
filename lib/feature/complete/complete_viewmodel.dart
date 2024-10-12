import 'package:caffely/feature/complete/bloc/mixin.dart';
import 'package:caffely/feature/complete/complete_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class ProfileCompleteViewModel extends BaseState<ProfileCompleteView>
    with ProfileCompleteMixin {
  final formProfileCompleteKey = GlobalKey<FormState>();

  late TextEditingController nameSurnameController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();

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
