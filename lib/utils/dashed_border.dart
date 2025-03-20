import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final Color color;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.strokeWidth = 1.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(strokeWidth: strokeWidth, color: color),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double dashWidth = 5;
  final double dashSpace = 3;

  DashedBorderPainter({required this.strokeWidth, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    Path dashPath = Path();
    double distance = 0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) => false;
}