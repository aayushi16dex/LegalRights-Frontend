import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class StateDropDownApi {
  // Code to fetch states details
  static Future<List<dynamic>> fetchStateApi(BuildContext context) async {
    final String fetchStateUrl = AppConfig.fetchState;
    final String authToken = await TokenManager.getAuthToken();
    try {
      final response = await http.get(Uri.parse(fetchStateUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch states'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during states fetch: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  static Future<List<dynamic>> fetchStateData(BuildContext context) async {
    final List<dynamic> stateList = await fetchStateApi(context);
    return stateList;
  }
}
