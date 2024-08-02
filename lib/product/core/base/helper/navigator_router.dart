import 'package:flutter/material.dart';

enum SlideDirection { leftToRight, rightToLeft, topToBottom, bottomToTop }

class CodeNoahNavigatorRouter {
  static void push(
    BuildContext context,
    Widget page, {
    SlideDirection direction = SlideDirection.rightToLeft,
  }) {
    Navigator.push(
      context,
      _createRoute(page, direction),
    );
  }

  static void pushAndRemoveUntil(
    BuildContext context,
    Widget page, {
    SlideDirection direction = SlideDirection.rightToLeft,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      _createRoute(page, direction),
      (Route<dynamic> route) => false,
    );
  }

  static PageRouteBuilder _createRoute(Widget page, SlideDirection direction) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin;
        switch (direction) {
          case SlideDirection.leftToRight:
            begin = const Offset(-1.0, 0.0);
            break;
          case SlideDirection.rightToLeft:
            begin = const Offset(1.0, 0.0);
            break;
          case SlideDirection.topToBottom:
            begin = const Offset(0.0, -1.0);
            break;
          case SlideDirection.bottomToTop:
            begin = const Offset(0.0, 1.0);
            break;
        }
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
