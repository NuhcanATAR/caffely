final class CustomValidator {
  CustomValidator({required this.value});

  final String? value;

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
      return "Zorunlu Alan";
    } else if (!isNumeric(value)) {
      return "Geçersiz Değer";
    }
    return null;
  }

  String? get emptyNormalCheck {
    // just string
    if (value == null || value!.isEmpty) {
      return "Zorunlu Alan";
    } else if (isNumeric(value) == true) {
      return "Geçersiz Değer";
    }
    return null;
  }

  String? get emailCheck {
    if (value == null || value!.isEmpty) {
      return "E-posta alanı boş bırakılamaz";
    } else if (!emailRegExp.hasMatch(value!)) {
      return "Geçersiz e-posta formatı";
    } else {
      return null;
    }
  }

  String? get passwordCheck {
    if (value == null || value!.isEmpty) {
      return "Şifre alanı boş bırakılamaz";
    } else if (value!.length < 8) {
      return "Şifre en az 8 karakter uzunluğunda olmalıdır";
    } else if (!value!.contains(RegExp(r'[A-Z]'))) {
      return "Şifre en az bir büyük harf içermelidir";
    } else if (!value!.contains(RegExp(r'[a-z]'))) {
      return "Şifre en az bir küçük harf içermelidir";
    } else if (!value!.contains(RegExp(r'[0-9]'))) {
      return "Şifre en az bir rakam içermelidir";
    } else if (!value!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Şifre en az bir özel karakter içermelidir";
    } else {
      return null;
    }
  }

  String? phoneNumberValidator(String? phoneNumberVal) {
    if (phoneNumberVal == null || phoneNumberVal.isEmpty) {
      return "Zorunlu Alan";
    } else if (!isNumeric(phoneNumberVal)) {
      return "Geçersiz Telefon Numarası";
    } else if (!phoneNumberRegExp.hasMatch(phoneNumberVal)) {
      return "Geçersiz Telefon Numarası";
    } else {
      return null;
    }
  }
}
