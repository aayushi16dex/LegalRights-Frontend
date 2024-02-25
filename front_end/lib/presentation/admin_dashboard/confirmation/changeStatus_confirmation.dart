import 'package:flutter/material.dart';

class ChangeStatusConfirmation {
  static void changeStatusConfirmation(
      BuildContext context, String deleteName, bool currentStatus) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
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
                'assets/images/successfully-added.gif',
                height: 50.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),
              Text(
                currentStatus
                    ? 'Deactivated Successfully'
                    : 'Activated Successfully',
                style: const TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
