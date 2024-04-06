import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/api_call/legalExpert_api/adminLegalExpertFieldApi.dart';

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
    List<Map<String, dynamic>> professionListField = [];
    List<Map<String, dynamic>> languageListField = [];
    List<Map<String, dynamic>> stateListField = [];
    List<Map<String, dynamic>> expertiseListField = [];
    AdminLegalExpertFieldApiCall api = AdminLegalExpertFieldApiCall();
    professionListField = await api.showProfessionList(context);
    languageListField = await api.showLanguageList(context);
    stateListField = await api.showStateList(context);
    expertiseListField = await api.showExpertiseList(context);

    // Function to get ID from name in the fetched list
    String getIdFromName(
        List<Map<String, dynamic>> list, String name, String fieldName) {
      return list.firstWhere((element) => element[fieldName] == name)['id'];
    }

    // Convert names to IDs
    String professionId =
        getIdFromName(professionListField, profession, 'professionName');
    String stateId = getIdFromName(stateListField, state, 'stateName');
    List<String> languageIds = languages
        .map((lang) => getIdFromName(languageListField, lang, 'languageName'))
        .toList();
    List<String> expertiseIds = expertises
        .map((expertise) =>
            getIdFromName(expertiseListField, expertise, 'expertiseName'))
        .toList();

    Map<String, dynamic> postData = {
      'experienceYears': experienceYears,
      'languagesKnown': languageIds,
      'expertise': expertiseIds,
      'profession': professionId,
      'state': stateId,
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
