import 'package:flutter/material.dart';

class DeleteProfileconfirmation {
  void deleteProfileConfirmationAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/successfully-register.gif',
                height: 200.0,
                width: 300.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10.0),
              const Text('Profile Deleted Successfully !!'),
            ],
          ),
        );
      },
    );
  }
}
