import 'package:caffely/feature/complete/bloc/mixin.dart';
import 'package:caffely/feature/complete/complete_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class ProfileCompleteViewModel extends BaseState<ProfileCompleteView>
    with ProfileCompleteMixin {
  final formProfileCompleteKey = GlobalKey<FormState>();

  TextEditingController nameSurnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // city distirct
  String? selectedCity;
  String? selectedDistrict;

  @override
  void dispose() {
    super.dispose();
    nameSurnameController.dispose();
    phoneNumberController.dispose();
  }

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
