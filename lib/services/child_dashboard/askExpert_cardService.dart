import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpert_apiCall.dart';
import 'package:frontend/presentation/child_dashboard/dialogue_alert/viewExpertScreen.dart';

class BuildAskExpertCardService {
  static void onViewClick(BuildContext context, String id) {
    Future<dynamic> expertDataFuture =
        LegalExpertApiCall.fetchExpertProfileByIdApi(context, id);
    expertDataFuture
        .then((value) => {callExpertDetailScreen(context, id, value)});
  }

  static dynamic callExpertDetailScreen(BuildContext context, String id,
      Map<String, dynamic> expertProfileData) async {
    String firstName = expertProfileData['firstName'] ?? '';
    String lastName = expertProfileData['lastName'] ?? '';
    String fullName = '$firstName $lastName';
    String email = expertProfileData['email'] ?? '';
    int yrsExperience = expertProfileData['experienceYears'] ?? 0;
    String professionName =
        expertProfileData['profession']['professionName'] ?? '';
    String stateName = expertProfileData['state']['name'] ?? '';
    List<dynamic> languageListDynamic = expertProfileData['languagesKnown'];
    List<dynamic> expertiseListDynamic = expertProfileData['expertise'];

    List<String> languageList = languageListDynamic
        .map((language) => language['languageName'] as String)
        .toList();
    List<String> expertiseList = expertiseListDynamic
        .map((expertise) => expertise['expertiseField'] as String)
        .toList();

    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ViewExpertDetailScreen(
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
