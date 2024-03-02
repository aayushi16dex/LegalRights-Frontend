import 'package:flutter/material.dart';

class MyTimeline extends StatelessWidget {
  final sectionId;
  const MyTimeline({super.key, required this.sectionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
      ),
      body: const Center(
        child: TimelineWidget(),
      ),
    );
  }
}

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            painter: TimelinePainter(),
            child: Container(
              height: 100, // Adjust the height of the timeline
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TimelineButton("Step 1", () {
                // Handle button click for Step 1
                print("Clicked on Step 1");
              }),
              TimelineButton("Step 2", () {
                // Handle button click for Step 2
                print("Clicked on Step 2");
              }),
              TimelineButton("Step 3", () {
                // Handle button click for Step 3
                print("Clicked on Step 3");
                print("Sectionid: $Widget.sectionId");
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class TimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double startY = 0;
    double endY = size.height;

    double centerX1 = size.width * 0.2;
    double centerX2 = size.width * 0.5;
    double centerX3 = size.width * 0.8;

    canvas.drawLine(Offset(centerX1, startY), Offset(centerX1, endY), paint);
    canvas.drawLine(Offset(centerX2, startY), Offset(centerX2, endY), paint);
    canvas.drawLine(Offset(centerX3, startY), Offset(centerX3, endY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TimelineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  TimelineButton(this.label, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
