import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';

class MyQueriesApi {
  // Post query by child
  Future<int> postQueryApiCall(Object expertId, String query) async {
    try {
      final String postquery = AppConfig.postquery;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.post(
        Uri.parse(postquery),
        body: json.encode({
          'expertId': expertId,
          'query': query,
        }),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return 200;
      } else {
        print('Failed to post query. Status code: ${response.statusCode}');
        return 500;
      }
    } catch (error) {
      print('Error posting query: $error');
      return 500;
    }
  }

  Future<List<Map<String, dynamic>>> fetchChildQueriesApi(
      BuildContext context) async {
    try {
      final String fetchUserQuery = AppConfig.fetchquery;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(fetchUserQuery), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> fetchedPastQueriesList = data['queryList'];
        return fetchedPastQueriesList.cast<Map<String, dynamic>>();
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch queries'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to fetch queries'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
