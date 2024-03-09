import 'dart:convert';
import 'package:frontend/model/header_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/core/config.dart';

class ProfileHeaderDataApiCal {
  static Future<String> profileDataApi(
      BuildContext context, String token) async {
    try {
      final String profileDataUrl = AppConfig.profileUrl;
      final response = await http.get(Uri.parse(profileDataUrl), headers: {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Adjust content type as needed
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // Check if 'userData' is present and not null
        if (data['userData'] != null) {
          String id = data['userData']['_id'];
          String userRole = data['userData']['role'];
          String fName = data['userData']['firstName'];
          String lName = data['userData']['lastName'] ?? " ";
          String joinDate = data['userData']['joinedOn'];
          String displayPic = data['userData']['displayPicture'] ?? " ";

          HeaderData.setProfileData(
              id, userRole, fName, lName, joinDate, displayPic);

          return userRole;
        } else {
          print("'userData' is null or not present in the response.");
          // Handle the absence of 'userData' in the response as needed.
        }
      }
    } catch (e) {
      print(e);
    }
    return '';
  }
}
