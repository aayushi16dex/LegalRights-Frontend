import 'dart:math';

import 'package:flutter/material.dart';

class SectionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Section 1 : ',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'PressStart2P'),
          textAlign: TextAlign.center,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 5; i++)
            Column(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    child: CustomPaint(
                      painter: CustomShapePainter(
                        isFacingLeft: i.isEven,
                        halfCirclePaintColor: i.isEven
                            ? const Color.fromARGB(255, 4, 37, 97)
                            : const Color.fromARGB(255, 238, 42, 12),
                        smallCirclePaintColor: i.isEven
                            ? const Color.fromARGB(255, 238, 42, 12)
                            : const Color.fromARGB(255, 4, 37, 97),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// class CustomShapePainter extends CustomPainter {
//   final bool isFacingLeft;
//   final Color halfCirclePaintColor;
//   final Color smallCirclePaintColor;

//   CustomShapePainter(
//       {required this.isFacingLeft,
//       required this.halfCirclePaintColor,
//       required this.smallCirclePaintColor});
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Paint halfCirclePaint = Paint()
//     //   ..strokeWidth = 1.0
//     //   ..color = halfCirclePaintColor
//     //   ..style = PaintingStyle.stroke;

//     Paint smallCirclePaint = Paint()
//       ..strokeWidth = 2.0
//       ..color = smallCirclePaintColor
//       ..style = PaintingStyle.fill;

//     double radius = size.width / 3;
//     Offset center = Offset(size.width / 2, size.height / 2);

//     // Draw the big half circle with background color

//     // double startAngle = isFacingLeft ? -pi / 2 : pi / 2;
//     // double sweepAngle = pi;

//     // canvas.drawArc(
//     //   Rect.fromCircle(center: center, radius: radius),
//     //   startAngle, // Start angle
//     //   sweepAngle, // Sweep angle
//     //   true,
//     //   halfCirclePaint,
//     // );
//     Paint linePaint = Paint()
//       ..strokeWidth = 10.0
//       ..color = halfCirclePaintColor;

//     double startX = size.width / 2;

//     canvas.drawLine(
//       Offset(startX, 0),
//       Offset(startX, size.height),
//       linePaint,
//     );

//     // Draw the small circle inside with a different background color
//     double smallCircleRadius = radius / 2;
//     canvas.drawCircle(center, smallCircleRadius, smallCirclePaint);

//     // Draw a horizontal line from the center of the small circle
//     double lineLength = size.width / 2;
//     double startXX = center.dx - (isFacingLeft ? lineLength : 0);
//     double endX = center.dx + (isFacingLeft ? 0 : lineLength);
//     double lineY = center.dy;

//     canvas.drawLine(
//       Offset(startXX, lineY),
//       Offset(endX, lineY),
//       Paint()
//         ..color = Colors.black
//         ..strokeWidth = 2,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

class CustomShapePainter extends CustomPainter {
  final bool isFacingLeft;
  final Color halfCirclePaintColor;
  final Color smallCirclePaintColor;
  final VoidCallback? onPressed;

  CustomShapePainter({
    required this.isFacingLeft,
    required this.halfCirclePaintColor,
    required this.smallCirclePaintColor,
    this.onPressed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..strokeWidth = 10.0
      ..color = halfCirclePaintColor;

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

    // Draw a horizontal line from the center of the small circle
    double lineLength = size.width / 2;
    double startXLine = center.dx - (isFacingLeft ? lineLength : 0);
    double endXLine = center.dx + (isFacingLeft ? 0 : lineLength);
    double lineY = center.dy;

    canvas.drawLine(
      Offset(startXLine, lineY),
      Offset(endXLine, lineY),
      Paint()
        ..color = Colors.black
        ..strokeWidth = 2,
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
      ..color = halfCirclePaintColor // Change the button color as needed
      ..style = PaintingStyle.fill;

    canvas.drawRRect(buttonRect, buttonPaint);

    // Draw text on the button
    TextPainter textPainter = TextPainter(
      text: const TextSpan(
        text: 'Click Me',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0,
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
