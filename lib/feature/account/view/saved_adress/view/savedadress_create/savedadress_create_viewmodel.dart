import 'package:caffely/feature/account/view/saved_adress/bloc/mixin.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class SavedAdressCreateViewModel
    extends BaseState<SavedadressCreateView> with SavedAdressMixin {
  final formAdressCreateKey = GlobalKey<FormState>();

  // controller
  late TextEditingController titleController = TextEditingController();
  late TextEditingController streetController = TextEditingController();
  late TextEditingController buildNoController = TextEditingController();
  late TextEditingController floorController = TextEditingController();
  late TextEditingController apartmentController = TextEditingController();
  late TextEditingController directionController = TextEditingController();
  late TextEditingController contactNameController = TextEditingController();
  late TextEditingController contactSurnameController = TextEditingController();
  late TextEditingController contactPhoneController = TextEditingController();

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
