import 'package:logger/logger.dart';

class CustomLoggerPrint {
  final Logger logger = Logger();

  void printInfoLog(String message) {
    logger.i(message);
  }

  void printErrorLog(String message) {
    logger.e(message);
  }

  void printWarningLog(String message) {
    logger.w(message);
  }
}
