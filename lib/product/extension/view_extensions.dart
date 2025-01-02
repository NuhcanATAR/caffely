import 'package:flutter/material.dart';

extension ViewExtension on BuildContext {
  Size get mediaSize => MediaQuery.sizeOf(this);
}
