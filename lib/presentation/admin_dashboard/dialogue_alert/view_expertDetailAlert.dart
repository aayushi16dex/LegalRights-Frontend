import 'package:flutter/material.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/viewExpertDetailScreen.dart';

class ViewExpertDetailAlert {
  static Future<void> viewExpertDetailAlert(
      BuildContext context, Map<String, dynamic> viewData) async {
    String id = viewData['_id'] ?? '';
    String firstName = viewData['firstName'] ?? '';
    String lastName = viewData['lastName'] ?? '';
    String fullName = '$firstName $lastName';
    String email = viewData['email'] ?? '';
    int yrsExperience = viewData['experienceYears'] ?? 0;
    String professionName = viewData['profession']['professionName'] ?? '';
    String stateName = viewData['state']['name'] ?? '';
    List<dynamic> languageListDynamic = viewData['languagesKnown'];
    List<dynamic> expertiseListDynamic = viewData['expertise'];

    List<String> languageList = languageListDynamic
        .map((language) => language['languageName'] as String)
        .toList();
    List<String> expertiseList = expertiseListDynamic
        .map((expertise) => expertise['expertiseField'] as String)
        .toList();

    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ViewExpertDetailScreen(
        id: id,
        fullName: fullName,
        email: email,
        yrsExperience: yrsExperience,
        professionName: professionName,
        stateName: stateName,
        languageList: languageList,
        expertiseList: expertiseList,
      ),
    ));
  }
}
