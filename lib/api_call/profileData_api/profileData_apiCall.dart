// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/model/header_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/core/config.dart';

class ProfileHeaderDataApiCal {
  static Future<String> profileDataApi(BuildContext context) async {
    try {
      final String profileDataUrl = AppConfig.profileUrl;
      final String token = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(profileDataUrl), headers: {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['userData'] != null) {
          String id = data['userData']['_id'];
          String email = data['userData']['email'];
          String userRole = data['userData']['role'];
          String fName = data['userData']['firstName'];
          String lName = data['userData']['lastName'] ?? " ";
          String joinDate = data['userData']['joinedOn'];
          String displayPic = data['userData']['displayPicture'] ?? " ";

          HeaderData.setProfileData(
              id, email, userRole, fName, lName, joinDate, displayPic);

          return userRole;
        } else {
          if (kDebugMode) {
            print("'userData' is null or not present in the response.");
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return '';
  }
}
