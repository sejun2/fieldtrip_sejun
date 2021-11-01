import 'package:flutter/material.dart';

class CustomProgressIndicator extends CustomPainter {
  int progressStatus = 0;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
