import 'package:flutter/material.dart';

class ErrorConfirmation {
  static void errorConfirmationAlert(
      BuildContext context, String errorMessage, String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorMessage),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
