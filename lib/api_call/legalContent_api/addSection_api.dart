import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;
import '../../core/TokenManager.dart';
import '../../core/config.dart';

class AddSectionApiCall {
  static Future<void> addSection(
    BuildContext context,
    String sectionNumber,
    String totalUnits,
    String title,
    String subTitle,
    String summary,
  ) async {
    try {
      final String apiUrl = AppConfig.addSection;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'sectionNumber': sectionNumber,
          'totalUnits': totalUnits,
          'title': title,
          'subTitle': subTitle,
          'summary': summary,
        }),
      );
      if (response.statusCode == 200) {
        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Section added successfully'),
            duration: Duration(seconds: 2), // Optional: Set the duration
          ),
        );
      } else {
        showErrorConfirmation(context, 'Failed to add section');
      }
    } catch (error) {
      // Handle network error and show error confirmation
      showErrorConfirmation(context, 'Network error');
    }
  }
}

void showErrorConfirmation(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
