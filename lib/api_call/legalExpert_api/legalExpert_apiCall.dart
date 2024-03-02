import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;
import '../../core/TokenManager.dart';
import '../../core/config.dart';

class LegalExpertApiCall {
  static Future<List<Map<String, dynamic>>> fetchLegalExpertListApiByAdmin(
      BuildContext context) async {
    try {
      final String fetchExpertList = AppConfig.fetchExpertsListByAdmin;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(fetchExpertList), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> fetchedExpertListFuture = data['expertList'];
        return fetchedExpertListFuture.cast<Map<String, dynamic>>();
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch legal expert in admin dashbaord'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      print(error);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during legal expert fetch fetch: $error'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  static Future<List<Map<String, dynamic>>> fetchLegalExpertListApiByUser(
      BuildContext context) async {
    try {
      final String fetchExpertListByUser = AppConfig.fetchexpertListByUser;
      final String authToken = await TokenManager.getAuthToken();
      final response =
          await http.get(Uri.parse(fetchExpertListByUser), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> fetchedExpertListFuture = data['expertList'];
        return fetchedExpertListFuture.cast<Map<String, dynamic>>();
      } else {
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch legal expert in admin dashbaord'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      print(error);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during legal expert fetch fetch: $error'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  // Fetch legal expert with id
  static Future<Map<String, dynamic>> fetchExpertProfileByIdApi(
      BuildContext context, Object expertId) async {
    try {
      final String profileUrl = '${AppConfig.fetchExpertById}/$expertId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(profileUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> expertProfileData =
            json.decode(response.body);
        return expertProfileData;
      } else {
        throw Exception('Failed to fetch profile data');
      }
    } catch (error) {
      print('Error fetching profile data: $error');
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during expert fetch: $error'),
        duration: const Duration(seconds: 2),
      )); // Return null in case of an error
    }
  }

  static Future<int> changeExpertStatusApi(
      BuildContext context, String expertId) async {
    const String errorMessage = 'Error';
    try {
      final String changeExpertStatusUrl =
          '${AppConfig.changeExpertStatus}/$expertId';
      final String authToken = await TokenManager.getAuthToken();

      final response =
          await http.put(Uri.parse(changeExpertStatusUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        print("Expert deleted Successfully");
        return response.statusCode;
      } else if (response.statusCode == 404) {
        print("Legal expert does not exists");
        return response.statusCode;
      } else {
        print("Unable to deactivate legal expert");
        return response.statusCode;
      }
    } catch (e) {
      ErrorConfirmation.errorConfirmationAlert(
          context, errorMessage, e.toString());
    }
    return 500;
  }
}
