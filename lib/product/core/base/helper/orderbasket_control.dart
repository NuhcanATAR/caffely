enum BasketMainStatusControl {
  orderReceived,
  orderInProgress,
  orderDelivered,
  orderRejected,
}

extension BasketMainStatusExtension on BasketMainStatusControl {
  int get value {
    switch (this) {
      case BasketMainStatusControl.orderReceived:
        return 1;
      case BasketMainStatusControl.orderInProgress:
        return 2;
      case BasketMainStatusControl.orderDelivered:
        return 3;
      case BasketMainStatusControl.orderRejected:
        return 4;
    }
  }
}

enum OrderProductStatusControl {
  orderInProgress,
  orderOnTheWay,
  orderDelivered,
  orderRejected,
}

extension OrderProductStatusExtension on OrderProductStatusControl {
  int get value {
    switch (this) {
      case OrderProductStatusControl.orderInProgress:
        return 1;
      case OrderProductStatusControl.orderOnTheWay:
        return 2;
      case OrderProductStatusControl.orderDelivered:
        return 3;
      case OrderProductStatusControl.orderRejected:
        return 4;
    }
  }
}

enum OrderBranchStatusControl {
  orderReceived,
  orderInProgress,
  orderOnTheWay,
  orderDelivered,
  orderRejected,
}

extension OrderBranchStatusExtension on OrderBranchStatusControl {
  int get value {
    switch (this) {
      case OrderBranchStatusControl.orderReceived:
        return 1;
      case OrderBranchStatusControl.orderInProgress:
        return 2;
      case OrderBranchStatusControl.orderOnTheWay:
        return 3;
      case OrderBranchStatusControl.orderDelivered:
        return 4;
      case OrderBranchStatusControl.orderRejected:
        return 5;
    }
  }
}

enum OrderPaymentType {
  online,
  payAtTheDoor,
}

extension OrderPaymentTypeControl on OrderPaymentType {
  int get value {
    switch (this) {
      case OrderPaymentType.online:
        return 1;
      case OrderPaymentType.payAtTheDoor:
        return 2;
    }
  }
}
