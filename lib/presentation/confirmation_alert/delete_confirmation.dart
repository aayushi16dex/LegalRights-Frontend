import 'package:flutter/material.dart';

class DeleteConfirmation {
  static void deleteConfirmationAlert(BuildContext context, String deleteName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                deleteName,
                style: const TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Image.asset(
                'assets/images/successfully-deleted.gif',
                height: 30.0,
                width: 50.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Deleted Successfully',
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
