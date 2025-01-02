import 'package:caffely/feature/account/view/saved_adress/bloc/mixin.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_create/savedadress_create_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class SavedAdressCreateViewModel
    extends BaseState<SavedadressCreateView> with SavedAdressMixin {
  final formAdressCreateKey = GlobalKey<FormState>();

  // controller
  TextEditingController titleController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildNoController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactSurnameController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();

  // city distirct
  String? selectedCity;
  String? selectedDistrict;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    streetController.dispose();
    buildNoController.dispose();
    floorController.dispose();
    apartmentController.dispose();
    directionController.dispose();
    contactNameController.dispose();
    contactSurnameController.dispose();
    contactPhoneController.dispose();
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
