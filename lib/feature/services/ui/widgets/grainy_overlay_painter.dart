import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class GrainyOverlayPainter extends CustomPainter {
  final Color grainColor;
  final double grainOpacity;
  final int density;

  const GrainyOverlayPainter({
    this.grainColor = Colors.white,
    this.grainOpacity = 0.05,
    this.density = 2000,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final paint =
        Paint()
          ..color = grainColor.withAlpha((grainOpacity * 255).toInt())
          ..strokeWidth = 1.0;

    for (int i = 0; i < density; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawPoints(PointMode.points, [Offset(x, y)], paint);
    }
  }

  @override
  bool shouldRepaint(covariant GrainyOverlayPainter oldDelegate) {
    return oldDelegate.grainColor != grainColor ||
        oldDelegate.grainOpacity != grainOpacity ||
        oldDelegate.density != density;
  }
}
