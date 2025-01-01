import 'package:caffely/product/extension/view_extensions.dart';
import 'package:flutter/material.dart';

class DynamicViewExtensions {
  double maxWidth(BuildContext context) =>
      ViewExtension(context).mediaSize.width;
  double maxHeight(BuildContext context) =>
      ViewExtension(context).mediaSize.height;

  double dynamicWidth(BuildContext context, double value) =>
      maxWidth(context) * value;
  double dynamicHeight(BuildContext context, double value) =>
      maxHeight(context) * value;
}
