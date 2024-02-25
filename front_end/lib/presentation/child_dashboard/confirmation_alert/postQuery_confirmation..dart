import 'package:flutter/material.dart';

class PostQueryconfirmation {
  void postQueryConfirmationAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        });
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/successfully-register.gif', // Replace with the actual URL of your success GIF
                height: 200.0,
                width: 300.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10.0),
              const Text('Query Posted Successfully !!'),
            ],
          ),
        );
      },
    );
  }
}
