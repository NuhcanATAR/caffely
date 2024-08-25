import 'package:intl/intl.dart';

class CodeNoahPriceConvert {
  static String formatPrice(int price) {
    final formatter = NumberFormat('#,###');
    return formatter.format(price);
  }

  static String formatPriceString(String price) {
    final int priceInt = int.tryParse(price.replaceAll(',', '')) ?? 0;
    return formatPrice(priceInt);
  }
}
