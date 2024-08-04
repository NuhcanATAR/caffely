import 'package:flutter/material.dart';

class IconSizedsUtility {
  static double hugeSize = 200.0;
  static double largeSecondSize = 55.0;
  static double largeSize = 40.0;
  static double mediumSecondSize = 30.0;
  static double mediumSize = 20.0;
  static double normalSize = 25.0;
  static double smallSize = 18.0;
  static double xSmallSize = 10.0;
}

class WidgetWidthHeightValueUtility {
  // width value

  // height value
  static double normalHeight = 0.10;
  static double standartHeight = 0.06;
  static double mediumHeight = 0.08;
  static double largeHeight = 0.15;
}

abstract class ColorUtility {
  static Color white = const Color(0xffFFFFFF);
  static Color black = const Color(0xff1C1B1B);
}

class PaddingSizedsUtility {
  static double hugePaddingValue = 125.0;
  static double hightPaddingValue = 55.0;
  static double normalPaddingValue = 16.0;
  static double mediumPaddingValue = 10.0;
  static double smallPaddingValue = 5.0;

  static EdgeInsets horizontal(double padding) =>
      EdgeInsets.symmetric(horizontal: padding);
  static EdgeInsets vertical(double padding) =>
      EdgeInsets.symmetric(vertical: padding);
  static EdgeInsets left(double padding) => EdgeInsets.only(left: padding);
  static EdgeInsets right(double padding) => EdgeInsets.only(right: padding);
  static EdgeInsets top(double padding) => EdgeInsets.only(top: padding);
  static EdgeInsets bottom(double padding) => EdgeInsets.only(bottom: padding);
  static EdgeInsets all(double padding) => EdgeInsets.all(padding);
}

class MarginSizedsUtility {
  static double hugeMarginValue = 125.0;
  static double hightMarginValue = 55.0;
  static double normalMarginValue = 16.0;
  static double mediumMarginValue = 10.0;
  static double smallMarginValue = 5.0;

  static EdgeInsets horizontal(double margin) =>
      EdgeInsets.symmetric(horizontal: margin);
  static EdgeInsets vertical(double margin) => EdgeInsets.symmetric(
        vertical: margin,
        horizontal: margin,
      );
  static EdgeInsets left(double margin) => EdgeInsets.only(left: margin);
  static EdgeInsets right(double margin) => EdgeInsets.only(right: margin);
  static EdgeInsets top(double margin) => EdgeInsets.only(top: margin);
  static EdgeInsets bottom(double margin) => EdgeInsets.only(bottom: margin);
  static EdgeInsets all(double margin) => EdgeInsets.all(margin);
}

class RadiusUtility {
  static double highRadiusValue = 20.0;
  static double normalRadiusValue = 12.0;
  static double lowRadiusValue = 4.0;

  static double circularHighValue = 124;
  static double circularNormalValue = 24;
  static double circularMediumValue = 15;
  static double circularLowValue = 4;
}
