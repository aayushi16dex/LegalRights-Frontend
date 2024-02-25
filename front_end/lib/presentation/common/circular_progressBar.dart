import 'package:flutter/material.dart';

class CustomeCircularProgressBar {
  static Widget customeCircularProgressBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth * 0.2; // Adjust the size as needed
        return Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(15),
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: MultiColorTween(
              begin: Colors.red,
              end: const Color.fromARGB(255, 21, 0, 92),
            ).animate(CurvedAnimation(
              parent: const AlwaysStoppedAnimation(1),
              curve: const Interval(0.5, 1.0, curve: Curves.linear),
            )),
          ),
        );
      },
    );
  }
}

class MultiColorTween extends Tween<Color> {
  MultiColorTween({required Color begin, required Color end})
      : super(begin: begin, end: end);

  @override
  Color lerp(double t) {
    return Color.lerp(begin, end, t)!;
  }
}
