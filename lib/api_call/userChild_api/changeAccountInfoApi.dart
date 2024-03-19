// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class ChangeAccountInfoApi {
  Future<int?> changeAccountInfo(BuildContext context, String id,
      String firstName, String lastName, String userRole) async {
    String apiUrl = '';
    try {
      if (userRole == "CHILD") {
        apiUrl = '${AppConfig.changeAccountInfo}/$id';
      } else if (userRole == "LEGAL_EXPERT") {
        apiUrl = '${AppConfig.changeExpertAccountInfo}/$id';
      }
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
        }),
      );
      return response.statusCode;
    } catch (e) {
      print("Error in change password: $e");
      return null;
    }
  }
}
