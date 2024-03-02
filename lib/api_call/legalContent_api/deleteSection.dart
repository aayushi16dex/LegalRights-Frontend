import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class DeleteSectionApi {
  static Future<int?> deleteSection(
      BuildContext context, String sectionId) async {
    try {
      final String apiUrl = AppConfig.deleteSection + '/$sectionId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      // Return the status code in both success and error cases
      return response.statusCode;
    } catch (error) {
      print('Error deleting section: $error');

      // Return a default value or handle other scenarios if needed
      return null;
    }
  }
}
