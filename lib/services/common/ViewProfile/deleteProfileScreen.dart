// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/api_call/userChild_api/deleteProfileApi.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/presentation/app_start/splash_screen.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/deleteProfileConfirmation.dart';

class DeleteProfileScreen extends StatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  _DeleteProfileScreenState createState() => _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends State<DeleteProfileScreen> {
  TextEditingController passwordController = TextEditingController();
  bool showPasswordInput = false;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You are going to permanently delete your account and its associated data that is with us.',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Text(
            'This action can\'t be undone.',
            style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 238, 32, 17),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (!showPasswordInput)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showPasswordInput = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 4, 37, 97),
              ),
              child: const Text(
                'I Confirm!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          if (showPasswordInput)
            Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Enter your password to proceed!',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 4, 37, 97),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 4, 37, 97),
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 4, 37, 97),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 4, 37, 97),
                      ),
                    ),
                    errorText: errorText,
                    errorStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _cancelButtonPressed();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _validateAndShowConfirmationDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 238, 32, 17),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _cancelButtonPressed() {
    setState(() {
      passwordController.clear();
      showPasswordInput = false;
      errorText = '';
    });
  }

  void _validateAndShowConfirmationDialog() {
    if (passwordController.text.isEmpty) {
      setState(() {
        errorText = 'Password cannot be empty';
      });
    } else {
      setState(() {
        errorText = '';
      });
      _showConfirmationDialog();
    }
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 37, 97),
            ),
          ),
          content: const Text('This will permanently delete your account.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 37, 97),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                int? statusCode = await DeleteProfileApi.deleteProfile(
                    context, passwordController.text);
                DeleteProfileconfirmation deleteProfileconfirmation =
                    DeleteProfileconfirmation();
                if (statusCode == 200) {
                  await TokenManager.clearTokens();
                  deleteProfileconfirmation
                      .deleteProfileConfirmationAlert(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()),
                    );
                  });
                } else if (statusCode == 400) {
                  showErrorConfirmation(
                      context, 'Incorrect password!!!\n\nPlease try again.');
                } else {
                  showErrorConfirmation(context, "An Error Occured!!!");
                }
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 238, 32, 17),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void showErrorConfirmation(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 4, 37, 97),
          ),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 37, 97),
              ),
            ),
          ),
        ],
      );
    },
  );
}
