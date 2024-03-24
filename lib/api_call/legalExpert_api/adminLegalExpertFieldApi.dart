import 'package:flutter/material.dart';
import 'package:frontend/api_call/dropdown_api/expertiseDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/languageDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/professionDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/stateDropdown_apiCall.dart';

class AdminLegalExpertFieldApiCall {
  // Fetch profession list
  Future<List<Map<String, dynamic>>> showProfessionList(
      BuildContext context) async {
    try {
      final List<dynamic> fetchedProfessions =
          await ProfessionDropDownApi.fetchProfessionData(context);
      return fetchedProfessions.map((item) {
        return {
          'id': item['_id'] ?? '',
          'professionName': item['professionName'] ?? '',
        };
      }).toList();
    } catch (e) {
      print('Error fetching profession: $e');
      return [];
    }
  }

  // Fetch language list
  Future<List<Map<String, dynamic>>> showLanguageList(
      BuildContext context) async {
    try {
      final List<dynamic> fetchedLanguages =
          await LanguageDropDownApi.fetchLanguageData(context);
      return fetchedLanguages.map((item) {
        return {
          'id': item['_id'] ?? '',
          'languageName': item['languageName'] ?? '',
        };
      }).toList();
    } catch (e) {
      print('Error fetching language Name: $e');
      return [];
    }
  }

  // Fetch state list
  Future<List<Map<String, dynamic>>> showStateList(BuildContext context) async {
    try {
      final List<dynamic> fetchedStates =
          await StateDropDownApi.fetchStateData(context);
      return fetchedStates.map((item) {
        return {
          'id': item['_id'] ?? '',
          'stateName': item['name'] ?? '',
        };
      }).toList();
    } catch (e) {
      print('Error fetching state: $e');
      return [];
    }
  }

  // Fetch profession list
  Future<List<Map<String, dynamic>>> showExpertiseList(
      BuildContext context) async {
    try {
      final List<dynamic> fetchedExpertise =
          await ExpertiseDropDownApi.fetchExpertiseData(context);
      return fetchedExpertise.map((item) {
        return {
          'id': item['_id'] ?? '',
          'expertiseName': item['expertiseField'] ?? '',
        };
      }).toList();
    } catch (e) {
      print('Error fetching expertise: $e');
      return [];
    }
  }
}
