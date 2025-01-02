enum ProductTypeControl {
  small,
  middle,
  large,
  all,
  smallMiddle,
  middleLarge,
  standart,
  notSelect,
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
      case ProductTypeControl.notSelect:
        return 0;
    }
  }
}

enum ProductCoffeAvaibleTypeControl {
  hot,
  ice,
  notSelect,
}

extension ProductCoffeAvaibleTypeControlExtension
    on ProductCoffeAvaibleTypeControl {
  int get coffeAvaibleTypeValue {
    switch (this) {
      case ProductCoffeAvaibleTypeControl.notSelect:
        return 1;
      case ProductCoffeAvaibleTypeControl.hot:
        return 2;
      case ProductCoffeAvaibleTypeControl.ice:
        return 3;
    }
  }
}

enum ProductCardType {
  veritical,
  horizontal,
}

extension ProductCardTypeExtension on ProductCardType {
  int get cardTypeValue {
    switch (this) {
      case ProductCardType.veritical:
        return 1;
      case ProductCardType.horizontal:
        return 2;
    }
  }
}
