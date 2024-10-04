import 'package:caffely/feature/account/view/langue/langue_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/model/langue_model/langue_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class LangueViewModel extends BaseState<LangueView> {
  Future<void> saveLanguage(String languageCode) async {
    await Provider.of<LanguageProvider>(context, listen: false)
        .setLanguage(languageCode);

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
