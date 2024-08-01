import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:flutter/services.dart';

class CodeNoahClipboard {
  static Future<void> copy(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
      return;
    } else {
      throw ServiceException('Lütfen metin girişi olacak şekilde ayarlayın');
    }
  }

  static Future<String> paste() async {
    final ClipboardData? data = await Clipboard.getData('text/plain');
    return data?.text?.toString() ?? "";
  }

  static Future<bool> controlC(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> controlV() async {
    final ClipboardData? data = await Clipboard.getData('text/plain');
    return data;
  }
}
