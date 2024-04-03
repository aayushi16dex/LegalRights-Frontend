// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class ChangeLegalDetailInfoApi {
  Future<int?> changeLegalAccountInfo(
    BuildContext context,
    String id,
    int experienceYears,
    String profession,
    String state,
    List<String> languages,
    List<String> expertises,
  ) async {
    Map<String, dynamic> postData = {
      'experienceYears': experienceYears,
      'languagesKnown': languages,
      'expertise': expertises,
      'profession': profession,
      'state': state,
    };
    try {
      String apiUrl = '${AppConfig.changeExpertAccountInfo}/$id';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(postData),
      );
      return response.statusCode;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
