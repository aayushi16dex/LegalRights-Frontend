import 'package:flutter/material.dart';
import 'package:frontend/dashboard/child/c_landingPage_screen.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import '../../core/role.dart';

class SignupConfirmation {
  static void signUpConfirmationAlert(BuildContext context, String role) {
    String errorMessage = 'No Such role exists';
    String error = '';
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
          if (role == roleChild) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const UserLandingScreen()),
            );
          } else if (role == roleLegalExpert) {
            Navigator.of(context).pop();
          } else if (role == roleAdmin) {
            Navigator.of(context).pop();
          } else {
            ErrorConfirmation.errorConfirmationAlert(
                context, errorMessage, error);
          }
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
              const Text('Registered Successfully'),
            ],
          ),
        );
      },
    );
  }
}
