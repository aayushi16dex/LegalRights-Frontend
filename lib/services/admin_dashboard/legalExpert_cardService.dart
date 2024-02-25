import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpert_apiCall.dart';

import 'package:frontend/presentation/admin_dashboard/dialogue_alert/view_expertDetailAlert.dart';

class BuildLegalExpertCardService {
  static void onViewClick(BuildContext context, String id) {
    Future<dynamic> expertDataFuture =
        LegalExpertApiCall.fetchExpertProfileByIdApi(context, id);
    expertDataFuture
        .then((value) => {callExpertDetailAlert(context, id, value)});
  }

  static dynamic callExpertDetailAlert(
      BuildContext context, String id, Map<String, dynamic> expertProfileData) {
    return ViewExpertDetailAlert.viewExpertDetailAlert(
        context, expertProfileData);
  }
}
