import 'dart:convert';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class AddSubSectionApi {
  static Future<void> addSubSection(
    String sectionId,
    List<String?> videoPaths,
  ) async {

    try {
      final String apiUrl = '${AppConfig.addSubSection}/$sectionId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'introductionVideo': videoPaths[0],
          'contentVideo1': videoPaths[1],
          'narratorVideo': videoPaths[2],
          'contentVideo2': videoPaths[3],
        }),
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
