import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;

class ExpertiseDropDownApi {
  // Function to fetch expertise list
  static Future<List<dynamic>> fetchExpertiseData(BuildContext context) async {
    final List<dynamic> expertiseList = await fetchExpertiseApi(context);
    return expertiseList;
  }

  // Code to fetch expertise details
  static Future<List<dynamic>> fetchExpertiseApi(BuildContext context) async {
    final String fetchExpertiseUrl = AppConfig.fetchExpertise;
    final String authToken = await TokenManager.getAuthToken();
    try {
      final response = await http.get(Uri.parse(fetchExpertiseUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data;
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch expertise'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during expertise fetch: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  // Api Call to add Expertise
  static Future<int> addExpertiseApi(
    BuildContext context,
    String apiData,
  ) async {
    const String errorMessage = 'Failed to add Expertise';
    try {
      final String addExpertiseUrl = AppConfig.addExpertise;
      var postData = {'expertiseField': apiData};
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.post(Uri.parse(addExpertiseUrl),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type':
                'application/x-www-form-urlencoded', // Adjust content type as needed
          },
          body: postData);
      if (response.statusCode == 201) {
        return response.statusCode;
      } else if (response.statusCode == 409) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      ErrorConfirmation.errorConfirmationAlert(
          context, errorMessage, e.toString());
    }
    return 500;
  }
}
