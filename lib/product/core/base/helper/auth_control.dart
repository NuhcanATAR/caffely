enum AuthControl {
  emailPasswordAuth,
  googleAuth,
}

extension AuthControlExtension on AuthControl {
  int get valueAuth {
    switch (this) {
      case AuthControl.emailPasswordAuth:
        return 1;
      case AuthControl.googleAuth:
        return 2;
    }
  }
}
