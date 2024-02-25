import 'package:flutter/material.dart';
import 'package:frontend/core/role.dart';
import 'package:frontend/api_call/register/register_apiCall.dart';
import 'package:frontend/model/signup_controller.dart';

class RegisterFormService {
  /// Validating email pattern
  static String? validateEmail(String? value) {
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final emailRegex = RegExp(pattern);

    return value!.isNotEmpty && !emailRegex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  // Validating password
  static String? validatePassword(String? value) {
    // Password should be at least 6 characters long
    // It should contain at least 1 special character
    // It should contain at least 1 digit
    const pattern = r'^(?=.*[!@#\$%^&*(),.?":{}|<>])(?=.*\d).{6,}$';
    final passwordRegex = RegExp(pattern);

    return value!.isNotEmpty && !passwordRegex.hasMatch(value)
        ? 'Password should be at least 6 characters long and include 1 special character and 1 digit'
        : null;
  }

  // Post data to register
  static void registerData(bool isAdmin, BuildContext context,
      SignupFieldController signupFieldController) {
    if (isAdmin) {
      List<String> languageList =
          signupFieldController.languageController.text.split(', ');
      List<String> expertiseList =
          signupFieldController.expertiseController.text.split(', ');
      Map<String, dynamic> legalExpertData = {
        'email': signupFieldController.emailController.text,
        'password': signupFieldController.passwordController.text,
        'firstName': signupFieldController.firstNameController.text,
        'lastName': signupFieldController.lastNameController.text,
        'role': roleLegalExpert,
        'experienceYears': signupFieldController.yearsOfExperience.text,
        'languagesKnown': languageList,
        'expertise': expertiseList,
        'profession': signupFieldController.professionController.text,
        'state': signupFieldController.stateController.text,
      };
      RegisterApiCall.registerUserApi(context, legalExpertData);
    } else {
      Map<String, String> userData = {
        'email': signupFieldController.emailController.text,
        'password': signupFieldController.passwordController.text,
        'firstName': signupFieldController.firstNameController.text,
        'lastName': signupFieldController.lastNameController.text,
        'role': roleChild,
      };
      RegisterApiCall.registerUserApi(context, userData);
    }
  }
}
