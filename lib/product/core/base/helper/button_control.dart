enum ButtonTypes {
  primaryColorButton,
  iconPrimaryColorButton,
  borderPrimaryColorButton,
  borderErrorColorButton,
}

extension ButtonType on ButtonTypes {
  int get buttonTypeValue {
    switch (this) {
      case ButtonTypes.primaryColorButton:
        return 1;
      case ButtonTypes.iconPrimaryColorButton:
        return 2;
      case ButtonTypes.borderPrimaryColorButton:
        return 3;
      case ButtonTypes.borderErrorColorButton:
        return 4;
    }
  }
}
