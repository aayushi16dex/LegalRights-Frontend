import 'package:flutter/material.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgetPasswordService {
  Future<void> sendResetPasswordEmail(
      String email, BuildContext context) async {
    final apiUrl =
        '${AppConfig.forgotPasswordUrl}'; // Replace with your actual backend API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        // Password reset email sent successfully
        Navigator.of(context).pop(); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reset Password Link Email Sent Successfully.'),
          ),
        );
      }
        else if (response.statusCode == 404) {
        // User not found
        Navigator.of(context).pop(); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found. Kindly sign up.'),
          ),
        );
      }  else {
        // Handle other status codes or errors
        print(
            'Error sending reset password email. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Error sending reset password email. Please try again.'),
          ),
        );
      }
    } catch (error) {
      // Handle network or other errors
      print('Error sending reset password email: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Error sending reset password email. Please try again.'),
        ),
      );
    }
  }

  void showForgotPasswordPopup(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Forgot Password',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
              color: Color.fromARGB(255, 4, 37, 97), // Set text color
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter your email to reset your password:',
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97), // Set text color
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97), // Set text color
                ),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 4, 37, 97), // Set text color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 4, 37, 97), // Set line color
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
              style: TextButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 4, 37, 97),
                foregroundColor: Colors.white, // Set text color to white
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logic to send reset password email
                sendResetPasswordEmail(emailController.text, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 4, 37, 97),
              ),
              child: const Text(
                'Send Link',
                style: TextStyle(
                  color: Colors.white
                ),
                ),
            ),
          ],
        );
      },
    );
  }
}
