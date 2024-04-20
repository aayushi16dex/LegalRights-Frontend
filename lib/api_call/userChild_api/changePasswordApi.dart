import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/model/header_data.dart';

class ChangePasswordApi {
  Future<int?> changePassword(
      BuildContext context, String oldPassword, String newPassword) async {
    String apiUrl = '';
    HeaderData headerData = HeaderData();
    String userRole = headerData.getUserRole();
    try {
      if (userRole == "CHILD") {
        apiUrl = AppConfig.changePassword;
      } else if (userRole == "LEGAL_EXPERT") {
        apiUrl = AppConfig.expertChangePassword;
      }
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );
      return response.statusCode;
    } catch (e) {
      print("Error in change password: $e");
      return null;
    }
  }
}
