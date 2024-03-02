import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;

class ProfessionDropDownApi {
  // Funciton to fetch profession list
  static Future<List<dynamic>> fetchProfessionData(BuildContext context) async {
    final List<dynamic> professionList = await fetchProfessionApi(context);
    return professionList;
  }

  /// Code to fetch profession details
  static Future<List<dynamic>> fetchProfessionApi(BuildContext context) async {
    final String fetchProfessionUrl = AppConfig.fetchProfession;
    final String authToken = await TokenManager.getAuthToken();
    try {
      final response = await http.get(Uri.parse(fetchProfessionUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        //print("professtion list send: $data");
        return data;
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch professions'),
          duration: Duration(seconds: 5),
        ));
      }
    } catch (e) {
      print(e);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during profession fetch: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  // Api Call to add profession
  static Future<int> addProfessionApi(
    BuildContext context,
    String apiData,
  ) async {
    const String errorMessage = 'Failed to add Profession';
    try {
      final String addProfessionUrl = AppConfig.addProfession;
      var postData = {'professionName': apiData};
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.post(Uri.parse(addProfessionUrl),
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
