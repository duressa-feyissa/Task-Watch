import 'dart:math' as math;
import 'package:flutter/material.dart';

class CircularTimerPainter extends CustomPainter {
  final BuildContext context;
  final double progress;
  final Gradient gradient;

  CircularTimerPainter({
    required this.progress,
    required this.gradient,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.0;

    final Paint backgroundPaint = Paint()
      ..color = const Color.fromARGB(255, 143, 144, 182).withOpacity(0.2)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, backgroundPaint);

    final Paint fillPaint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    final double arcAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      arcAngle,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
