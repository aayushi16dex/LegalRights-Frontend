// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously
import 'dart:convert';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/api_call/profileData_api/profileData_apiCall.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../core/config.dart';
import '../../presentation/confirmation_alert/error_confirmation.dart';
import '../../presentation/confirmation_alert/signin_confirmation.dart';

enum UserType { user, admin, legalExpert }

class SignInApiCall {
  static String error = '';
  String errorMessage = 'Failed to Sign in!';
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';

  Future<void> authenticateUserApi(
      BuildContext context, String email, String password) async {
    final String userSignInUrl = '${AppConfig.signInUrl}';
    try {
      final userResponse = await http.post(Uri.parse(userSignInUrl), headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }, body: {
        'email': email,
        'password': password
      });

      final Map<String, dynamic> data = json.decode(userResponse.body);
      if (userResponse.statusCode == 200) {
        final String role = data['userData']['role'] ?? '';
        final String authToken = data['token'] ?? '';
        final String userId = data['userData']['_id'] ?? '';
        await TokenManager.storeAuthToken(authToken);
        ProfileHeaderDataApiCal.profileDataApi(context, authToken);
        SignInConfirmation.signInConfirmationAlert(context, role);
      } else {
        error = data['msg'];
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
      }
    } catch (e) {
      print('Error during sign-in: $e');
      ErrorConfirmation.errorConfirmationAlert(
          context, errorMessage, e as String);
    }
  }
}
