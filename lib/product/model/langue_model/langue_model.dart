import 'package:caffely/product/core/service/locatizations_service/localization_service.dart';
import 'package:flutter/foundation.dart';

class LanguageProvider with ChangeNotifier {
  String _selectedLanguage = 'en';

  String get selectedLanguage => _selectedLanguage;

  Future<void> loadLanguage() async {
    final languageCode = await LocalizationService().getLanguageCode();
    if (languageCode != null) {
      _selectedLanguage = languageCode;
      notifyListeners();
    }
  }

  Future<void> setLanguage(String languageCode) async {
    await LocalizationService().setLanguageCode(languageCode);
    _selectedLanguage = languageCode;
    notifyListeners();
  }
}
