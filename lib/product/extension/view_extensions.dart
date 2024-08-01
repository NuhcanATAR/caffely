import 'package:flutter/material.dart';

extension ViewSizeModelExtension on BuildContext {
  Size get mediaSize => MediaQuery.sizeOf(this);
}
