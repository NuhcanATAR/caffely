enum StoreDeliveryTimeFrameControl {
  deliveryTimeFramOne,
  deliveryTimeFramTwo,
  deliveryTimeFramThree,
}

extension StoreDeliveryTimeFrameControlExtension
    on StoreDeliveryTimeFrameControl {
  int get deliveryTimeFrameValue {
    switch (this) {
      case StoreDeliveryTimeFrameControl.deliveryTimeFramOne:
        return 1;
      case StoreDeliveryTimeFrameControl.deliveryTimeFramTwo:
        return 2;
      case StoreDeliveryTimeFrameControl.deliveryTimeFramThree:
        return 3;
    }
  }
}

extension StoreDeliveryTimeFrameStringControlExtension
    on StoreDeliveryTimeFrameControl {
  String get deliveryTimeFrameStringValue {
    switch (this) {
      case StoreDeliveryTimeFrameControl.deliveryTimeFramOne:
        return "20 - 30 Dakika";
      case StoreDeliveryTimeFrameControl.deliveryTimeFramTwo:
        return "40 - 50 Dakika";
      case StoreDeliveryTimeFrameControl.deliveryTimeFramThree:
        return "1 Saat";
    }
  }
}
