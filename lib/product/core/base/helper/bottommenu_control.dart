enum BottomMenuViews {
  home,
  store,
  order,
  favorite,
  profile,
}

extension BottomMenuViewExtension on BottomMenuViews {
  int get menuValue {
    switch (this) {
      case BottomMenuViews.home:
        return 0;
      case BottomMenuViews.store:
        return 1;
      case BottomMenuViews.order:
        return 2;
      case BottomMenuViews.favorite:
        return 3;
      case BottomMenuViews.profile:
        return 4;
    }
  }
}
