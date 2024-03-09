// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class DeleteProfileApi {
  static Future<int?> deleteProfile(BuildContext context, String userId) async {
    try {
      final String apiUrl = '${AppConfig.deleteProfile}/$userId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode;
    } catch (error) {
      print('Error deleting section: $error');
      return null;
    }
  }
}
