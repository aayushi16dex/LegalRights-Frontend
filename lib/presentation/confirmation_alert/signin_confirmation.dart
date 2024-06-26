import 'package:flutter/material.dart';
import 'package:frontend/core/role.dart';
import 'package:frontend/dashboard/admin/a_landingPage_screen.dart';
import 'package:frontend/dashboard/legal_expert/e_landingPage_screen.dart';
import 'package:frontend/dashboard/child/c_landingPage_screen.dart';

class SignInConfirmation {
  static void signInConfirmationAlert(BuildContext context, String role) {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LegalExpertLandingScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AdminLandingScreen()),
            );
          }
        });
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/successful-sign.gif',
                height: 150.0,
                width: 300.0,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Signed in Successfully',
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
