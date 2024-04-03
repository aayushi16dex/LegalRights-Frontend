import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class UploadProfilePicApi {
  Future<dynamic> uploadProfilePic(
      BuildContext context, String imageUrl) async {
    try {
      final String apiUrl = AppConfig.uploadProfilePicture;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'displayPicture': imageUrl
        }),
      );
      return response;
    } catch (e) {
      print("Error in uploading display picture: $e");
      return null;
    }
  }
}
