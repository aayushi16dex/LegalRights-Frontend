import 'package:flutter/material.dart';

class UpdateConfirmationAlert {
  static void showUpdateConfirmationDialog(
      BuildContext context, String updateName) {
    //Navigator.of(context).pop();
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
              Text(
                updateName,
                style: const TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Image.asset(
                'assets/images/successfully-added.gif',
                height: 100.0,
                width: 200.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Updated Successfully',
                style: TextStyle(
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
