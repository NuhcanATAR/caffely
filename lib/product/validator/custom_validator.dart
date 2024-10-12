import 'package:caffely/lang/app_localizations.dart';
import 'package:flutter/material.dart';

final class CustomValidator {
  CustomValidator({required this.value, required this.context});

  final String? value;
  final BuildContext context;

  // integer control
  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  // regexp
  final phoneNumberRegExp = RegExp(r"^[1-9][0-9]{9}$");
  final emailRegExp =
      RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");

  String? get emptyNumberCheck {
    // just number
    if (value == null || value!.isEmpty) {
      return AppLocalizations.of(context)!.validator_error;
    } else if (!isNumeric(value)) {
      return AppLocalizations.of(context)!.validator_invalid_value;
    }
    return null;
  }

  String? get emptyNormalCheck {
    // just string
    if (value == null || value!.isEmpty) {
      return AppLocalizations.of(context)!.validator_error;
    } else if (isNumeric(value) == true) {
      return AppLocalizations.of(context)!.validator_invalid_value;
    }
    return null;
  }

  String? get emailCheck {
    if (value == null || value!.isEmpty) {
      return AppLocalizations.of(context)!.validator_email_empty;
    } else if (!emailRegExp.hasMatch(value!)) {
      return AppLocalizations.of(context)!.validator_email_error;
    } else {
      return null;
    }
  }

  String? get passwordCheck {
    if (value == null || value!.isEmpty) {
      return AppLocalizations.of(context)!.validator_password_empty;
    } else if (value!.length < 8) {
      return AppLocalizations.of(context)!.validator_password_error_one;
    } else if (!value!.contains(RegExp(r'[A-Z]'))) {
      return AppLocalizations.of(context)!.validator_password_error_second;
    } else if (!value!.contains(RegExp(r'[a-z]'))) {
      return AppLocalizations.of(context)!.validator_password_error_three;
    } else if (!value!.contains(RegExp(r'[0-9]'))) {
      return AppLocalizations.of(context)!.validator_password_error_four;
    } else if (!value!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return AppLocalizations.of(context)!.validator_password_error_five;
    } else {
      return null;
    }
  }

  String? phoneNumberValidator(String? phoneNumberVal) {
    if (phoneNumberVal == null || phoneNumberVal.isEmpty) {
      return AppLocalizations.of(context)!.validator_phone_number_empty;
    } else if (!isNumeric(phoneNumberVal)) {
      return AppLocalizations.of(context)!.validator_phone_number_error;
    } else if (!phoneNumberRegExp.hasMatch(phoneNumberVal)) {
      return AppLocalizations.of(context)!.validator_phone_number_error_second;
    } else {
      return null;
    }
  }
}
