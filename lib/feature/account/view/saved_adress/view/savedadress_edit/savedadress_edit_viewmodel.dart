import 'package:caffely/feature/account/view/saved_adress/bloc/mixin.dart';
import 'package:caffely/feature/account/view/saved_adress/view/savedadress_edit/savedadress_edit_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class SavedadressEditViewmodel extends BaseState<SavedAdressEditView>
    with SavedAdressMixin {
  final formAdressEditKey = GlobalKey<FormState>();

  // controller
  late TextEditingController titleController = TextEditingController(
    text: widget.savedAdressModel.adressTitle,
  );
  late TextEditingController streetController = TextEditingController(
    text: widget.savedAdressModel.adressStreet,
  );

  late TextEditingController floorController = TextEditingController(
    text: widget.savedAdressModel.adressFloor.toString(),
  );
  late TextEditingController apartmentController = TextEditingController(
    text: widget.savedAdressModel.adressAparmentNo.toString(),
  );
  late TextEditingController directionController = TextEditingController(
    text: widget.savedAdressModel.adressDirections,
  );
  late TextEditingController contactNameController = TextEditingController(
    text: widget.savedAdressModel.contactName,
  );
  late TextEditingController contactSurnameController = TextEditingController(
    text: widget.savedAdressModel.contactSurname,
  );
  late TextEditingController contactPhoneController = TextEditingController(
    text: widget.savedAdressModel.contactPhoneNumber.toString(),
  );

  // city distirct
  late String? selectedCity = widget.savedAdressModel.adressCity;
  late String? selectedDistrict = widget.savedAdressModel.adressDistrict;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    streetController.dispose();
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
