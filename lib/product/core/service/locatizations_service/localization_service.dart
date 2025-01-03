import 'package:caffely/product/core/base/helper/shared_service.dart';

class LocalizationService {
  static const _keyLanguage = 'language_code';

  final PrefService _prefService = PrefService();

  LocalizationService._privateConstructor();
  static final LocalizationService instance =
      LocalizationService._privateConstructor();

  Future<void> setLanguageCode(String languageCode) async {
    await _prefService.saveString(_keyLanguage, languageCode);
  }

  Future<String?> getLanguageCode() async {
    return _prefService.getString(_keyLanguage);
  }
}
