import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;

class LanguageDropDownApi {
  // Function to fetch language list
  static Future<List<dynamic>> fetchLanguageData(BuildContext context) async {
    final List<dynamic> languageList = await fetchLanguageApi(context);
    return languageList;
  }

  /// Code to fetch language details
  static Future<List<dynamic>> fetchLanguageApi(BuildContext context) async {
    final String fetchLanguageUrl = AppConfig.fetchLanguage;
    final String authToken = await TokenManager.getAuthToken();
    try {
      final response = await http.get(Uri.parse(fetchLanguageUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data;
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch languages'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during language fetch: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  // Api Call to add Language
  static Future<int> addLanguageApi(
    BuildContext context,
    String apiData,
  ) async {
    const String errorMessage = 'Failed to add Language';
    try {
      final String addLanguageUrl = AppConfig.addLanguage;
      var postData = {'languageName': apiData};
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.post(Uri.parse(addLanguageUrl),
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
