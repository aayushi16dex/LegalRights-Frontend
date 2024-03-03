import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  final bool isFacingLeft;
  final Color linePaintColor;
  final Color smallCirclePaintColor;
  final VoidCallback? onPressed;

  CustomShapePainter({
    required this.isFacingLeft,
    required this.linePaintColor,
    required this.smallCirclePaintColor,
    this.onPressed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..strokeWidth = 10.0
      ..color = linePaintColor;

    double radius = size.width / 3;
    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw the vertical line (half circle)
    double startX = size.width / 2;
    canvas.drawLine(
      Offset(startX, 0),
      Offset(startX, size.height),
      linePaint,
    );

    // Draw the small circle inside with a different background color
    Paint smallCirclePaint = Paint()
      ..strokeWidth = 2.0
      ..color = smallCirclePaintColor
      ..style = PaintingStyle.fill;
    double smallCircleRadius = radius / 2;
    canvas.drawCircle(center, smallCircleRadius, smallCirclePaint);

    // Draw the small circle inside with a different background color

    // Draw a horizontal line from the center of the small circle
    double lineLength = size.width / 2;
    double startXLine = center.dx - (isFacingLeft ? lineLength : 0);
    double endXLine = center.dx + (isFacingLeft ? 0 : lineLength);
    double lineY = center.dy;

    canvas.drawLine(
      Offset(startXLine, lineY),
      Offset(endXLine, lineY),
      Paint()
        ..color = linePaintColor
        ..strokeWidth = 2.5,
    );

    // Attach a clickable rounded-corner button at the end of the horizontal line
    double buttonWidth = 100.0;
    double buttonHeight = 50.0;

    // Calculate the button position based on whether the line is facing left or right
    double buttonX = isFacingLeft ? startXLine - buttonWidth : endXLine;
    double buttonY = lineY - buttonHeight / 2;

    RRect buttonRect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(buttonX, buttonY),
        Offset(buttonX + buttonWidth, buttonY + buttonHeight),
      ),
      const Radius.circular(12.0), // Adjust the border radius
    );

    Paint buttonPaint = Paint()
      ..color = linePaintColor // Change the button color as needed
      ..style = PaintingStyle.fill;

    canvas.drawRRect(buttonRect, buttonPaint);

    // Draw text on the button
    TextPainter textPainter = TextPainter(
      text: const TextSpan(
        text: 'Video',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        buttonX + (buttonWidth - textPainter.width) / 2,
        buttonY + (buttonHeight - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
