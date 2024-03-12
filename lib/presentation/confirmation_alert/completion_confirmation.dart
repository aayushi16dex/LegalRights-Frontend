import 'package:flutter/material.dart';

class CompletionConfirmation {
  static void completionConfirmationAlert(BuildContext context, int number) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/completion.gif', // Replace with the actual URL of your success GIF
                height: 200.0,
                width: 300.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Unit $number Successfully Completed',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
