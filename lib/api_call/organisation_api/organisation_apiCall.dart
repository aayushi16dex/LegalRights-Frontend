import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;
import '../../core/TokenManager.dart';
import '../../core/config.dart';

class OrganisationApiCall {
  // Fetch List of Organsation
  static Future<List<Map<String, dynamic>>> fetchOrganisationListApi(
      BuildContext context) async {
    try {
      final String fetchOrganisationList = AppConfig.fetchOrganisationList;
      final String authToken = await TokenManager.getAuthToken();
      final response =
          await http.get(Uri.parse(fetchOrganisationList), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> fetchOrganisationListFuture = data['orgList'];
        return fetchOrganisationListFuture.cast<Map<String, dynamic>>();
      } else {
        print(response.statusCode);
        throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to fetch organisation'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (error) {
      print(error);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during organisation fetch: $error'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  // Fetch organisation with id
  static Future<Map<String, dynamic>> fetchOrganisationByIdApi(
      BuildContext context, Object orgId) async {
    try {
      final String fetchOrganisationUrl =
          '${AppConfig.fetchOrganisationById}/$orgId';
      final String authToken = await TokenManager.getAuthToken();
      final response =
          await http.get(Uri.parse(fetchOrganisationUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> organisationData =
            json.decode(response.body);
        return organisationData;
      } else {
        throw Exception('Failed to fetch organisation');
      }
    } catch (error) {
      print('Error fetching organisaton data: $error');
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error during organisation fetch: $error'),
        duration: const Duration(seconds: 2),
      )); // Return null in case of an error
    }
  }

  static Future<int> deleteOrganisationApi(
      BuildContext context, Object orgId) async {
    const String errorMessage = 'Error';
    try {
      final String deleteOrgUrl = '${AppConfig.deleteOrganisation}/$orgId';
      final String authToken = await TokenManager.getAuthToken();

      final response = await http.delete(Uri.parse(deleteOrgUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        print("Organisation deleted Successfully");
        return response.statusCode;
      } else if (response.statusCode == 404) {
        print("Organisaiton does not exists");
        return response.statusCode;
      } else {
        print("Unable to change status of organisation");
        return response.statusCode;
      }
    } catch (e) {
      ErrorConfirmation.errorConfirmationAlert(
          context, errorMessage, e.toString());
    }
    return 500;
  }

  // Api call to add organisation
  static Future<int> addOrganisationApi(
      BuildContext context, Map postData) async {
    try {
      final addOrganisationUrl = AppConfig.addorEditOrganisation;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.post(Uri.parse(addOrganisationUrl),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json', // Adjust content type as needed
          },
          body: jsonEncode(postData));
      if (response.statusCode == 200) {
        print("Organisation Added Successfully");
        return response.statusCode;
      } else if (response.statusCode == 409) {
        print("Organisation Already Exists");
        return response.statusCode;
      } else {
        print("Error in adding dropdown details");
        return response.statusCode;
      }
    } catch (e) {
      ErrorConfirmation.errorConfirmationAlert(
          context, 'Error Occured!', e.toString());
    }
    return 500;
  }

  // Api call to update organisation
  static Future<int> updateOrganisationApi(
      BuildContext context, Map postData, Object orgId) async {
    try {
      final updateOrganisationUrl = '${AppConfig.addorEditOrganisation}/$orgId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.put(Uri.parse(updateOrganisationUrl),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json', // Adjust content type as needed
          },
          body: jsonEncode(postData));
      if (response.statusCode == 200) {
        print("Organisation updated Successfully");
        return response.statusCode;
      } else {
        print("Error in updating   details");
        return response.statusCode;
      }
    } catch (e) {
      ErrorConfirmation.errorConfirmationAlert(
          context, 'Error Occured!', e.toString());
    }
    return 500;
  }
}
