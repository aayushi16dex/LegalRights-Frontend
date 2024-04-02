import 'package:flutter/material.dart';

class UpdateImageConfirmationAlert {
  static void showImageUpdateConfirmationDialog(
      BuildContext context, String updateName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
         Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/successfully-added.gif',
                height: 100.0,
                width: 200.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),
              Text(
                '$updateName updated Successfully',
                style: const TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontSize: 20.0,
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
