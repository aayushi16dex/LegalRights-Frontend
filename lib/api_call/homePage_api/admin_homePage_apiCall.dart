import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/TokenManager.dart';
import '../../core/config.dart';

class HomePageApiCall {
  /// Code to fetch count
  Future<Map<String, dynamic>> fetchCountApi(BuildContext context) async {
    final String fetchCountUrl = AppConfig.fetchCount;
    try {
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(fetchCountUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch count'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during user fetch: $e'),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
