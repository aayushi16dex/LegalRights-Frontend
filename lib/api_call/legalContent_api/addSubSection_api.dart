import 'dart:convert';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;

class AddSubSectionApi {
  static Future<int> addSubSection(
    String sectionId,
    Map<int, String?> videoUrls,
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
          'introductionVideo': videoUrls[1],
          'contentVideo1': videoUrls[2],
          'narratorVideo': videoUrls[3],
          'contentVideo2': videoUrls[4],
        }),
      );

      if (response.statusCode == 200) {
        return 200;
      } else {
        return 500;
      }
    } catch (error) {
      print('Error: $error');
      return 500;
    }
  }
}
