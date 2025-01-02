enum ProductFilterControl {
  favoriteFilter,
  notFavoriteFilter,
}

extension ProductFilterControlExtension on ProductFilterControl {
  bool get productFilterValue {
    switch (this) {
      case ProductFilterControl.favoriteFilter:
        return true;
      case ProductFilterControl.notFavoriteFilter:
        return false;
    }
  }
}
