// ignore_for_file: avoid_print, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class DeleteProfileApi {
  static Future<int?> deleteProfile(
      BuildContext context, String password) async {
    try {
      final String apiUrl = AppConfig.deleteProfile;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'password': password,
        }),
      );
      return response.statusCode;
    } catch (error) {
      print('Error deleting section: $error');
      return null;
    }
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
