enum ProductTypeControl {
  small,
  middle,
  large,
  all,
  smallMiddle,
  middleLarge,
  standart,
}

extension ProducttypeControlExtension on ProductTypeControl {
  int get productTypeValue {
    switch (this) {
      case ProductTypeControl.small:
        return 1;
      case ProductTypeControl.middle:
        return 2;
      case ProductTypeControl.large:
        return 3;
      case ProductTypeControl.all:
        return 4;
      case ProductTypeControl.smallMiddle:
        return 5;
      case ProductTypeControl.middleLarge:
        return 6;
      case ProductTypeControl.standart:
        return 7;
    }
  }
}
