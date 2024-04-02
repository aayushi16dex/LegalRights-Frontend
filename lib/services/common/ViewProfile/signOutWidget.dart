import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/presentation/app_start/splash_screen.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/signOutConfirmation.dart';

class SignOutWidget {
  static Widget signOut(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                "Log Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 37, 97),
                ),
              ),
              content: const Text("Are you sure you want to log out?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(
                      color: Color.fromARGB(255, 4, 37, 97),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    signOutFunction(context);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 32, 17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: 0.5 * screenWidth,
        margin: const EdgeInsets.only(top: 8, bottom: 48, right: 20, left: 20),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 32, 17),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Log Out',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  
}

void signOutFunction(BuildContext context) async {
    await TokenManager.clearTokens();
    SignOutconfirmation signOutconfirmation = SignOutconfirmation();
    signOutconfirmation.signOutConfirmationAlert(context);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    });
  }