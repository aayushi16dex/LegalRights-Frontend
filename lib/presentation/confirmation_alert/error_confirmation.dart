import 'package:flutter/material.dart';

class ErrorConfirmation {
  static void errorConfirmationAlert(
    BuildContext context,
    String errorMessage,
    String error,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            errorMessage,
            style: const TextStyle(
              color: Color.fromARGB(255, 4, 37, 97),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
