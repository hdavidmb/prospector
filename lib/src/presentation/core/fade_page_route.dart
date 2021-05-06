import 'package:flutter/material.dart';

class FadePageRoute {
    PageRouteBuilder call({required Widget page}) => PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            page,
        transitionDuration: const Duration(seconds: 1),
        // reverseTransitionDuration: Duration(seconds: 2),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation =
              CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return FadeTransition(
            opacity:
                Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
            child: child,
          );
        },
      );
}
