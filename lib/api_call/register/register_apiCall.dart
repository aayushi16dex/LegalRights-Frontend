// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/api_call/profileData_api/profileData_apiCall.dart';
import 'package:frontend/core/role.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/signup_confirmation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/config.dart';

class RegisterApiCall {
  static String errorMessage = 'Failed to Register!!';
  static String error = '';
  static Future<void> registerUserApi(
      BuildContext context, Map postData) async {
    String? roleFromPostData = postData['role'];
    final String signupUrl;
    try {
      if (roleFromPostData == roleLegalExpert) {
        signupUrl = '${AppConfig.legalExpertRegisterUrl}';
      } else if (roleFromPostData == roleChild) {
        signupUrl = '${AppConfig.userSignUpUrl}';
      } else {
        // Handle unknown roles appropriately (throw an exception, set a default URL, etc.).
        throw Exception('Unknown role: $roleFromPostData');
      }
      final response = await http.post(Uri.parse(signupUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(postData));
      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        final String role = data['userData']['role'];
        final String authToken = data['token'] ?? '';
        await TokenManager.storeAuthToken(authToken);
        ProfileHeaderDataApiCal.profileDataApi(context, authToken);
        SignupConfirmation.signUpConfirmationAlert(context, role);
      } else if (response.statusCode == 409) {
        error = data['msg'];
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
      } else {
        error = data['msg'];
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
      }
    } catch (e) {
      print(e);
      ErrorConfirmation.errorConfirmationAlert(
          context, errorMessage, e.toString());
    }
  }
}
