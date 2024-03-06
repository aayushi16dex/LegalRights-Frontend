import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/TokenManager.dart';
import '../../core/config.dart';

class SectionApiCall {
  static Future<List<Map<String, dynamic>>> fetchSectionApi(
      BuildContext context) async {
    try {
      final String fetchSectionUrl = AppConfig.fetchSections;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(
        Uri.parse(fetchSectionUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> sectionList = data['sectionList'];
        final List<Map<String, dynamic>> sections = sectionList.map((query) {
          return {
            '_id': query['_id'].toString(),
            'sectionNumber': query['sectionNumber'],
            'totalUnits': query['totalUnits'],
            'title': query['title'].toString(),
            'subTitle': query['subTitle'].toString(),
            'summary': query['summary'].toString()
          };
        }).toList();
        return sections;
      } else {
        throw Exception('Failed to fetch sections');
      }
    } catch (error, stackTrace) {
      print('Error fetching sections: $error');
      print(stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching sections: $error'),
        duration: const Duration(seconds: 2),
      ));
      return [];
    }
  }

  static Future<Map<String, dynamic>> fetchSectionByIdApi(
      BuildContext context, Object sectionId) async {
    try {
      final String fetchSectionUrl =
          '${AppConfig.fetchSectionContentById}/$sectionId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(
        Uri.parse(fetchSectionUrl),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> subSections = data['sectionData'];
        return subSections;
      } else {
        throw Exception('Failed to fetch sections by Id');
      }
    } catch (error, stackTrace) {
      print('Error fetching sub section sections: $error');
      print(stackTrace);
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching sections: $error'),
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
