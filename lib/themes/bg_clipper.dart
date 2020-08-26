import 'package:flutter/material.dart';

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.arcToPoint(Offset(size.width, size.height),
    //     radius: Radius.elliptical(40, 10));

    path.quadraticBezierTo(size.width * 0.6, size.height * 0.2, size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.8, 0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
