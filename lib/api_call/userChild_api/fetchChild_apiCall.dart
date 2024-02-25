import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/TokenManager.dart';
import '../../core/config.dart';

class FetchChildApiCall {
  static Future<List<Map<String, dynamic>>> fetchChildListApi(
      BuildContext context) async {
    try {
      final String fetchChildList = AppConfig.fetchAllUser;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(fetchChildList), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> fetchedchildListFuture = data['userList'];
        return fetchedchildListFuture.cast<Map<String, dynamic>>();
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch user'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      print(error);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during user fetch: $error'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  // Fetch legal expert with id
  static Future<Map<String, dynamic>> fetchChildProfileByIdApi(
      BuildContext context, Object userId) async {
    try {
      final String fetchUserById = '${AppConfig.fetchUserById}/$userId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(fetchUserById), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> userProfileData = json.decode(response.body);
        return userProfileData;
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during expert fetch: $error'),
        duration: const Duration(seconds: 2),
      )); // Return null in case of an error
    }
  }
}
