// ignore_for_file: unused_local_variable, file_names, deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:frontend/api_call/organisation_api/organisation_apiCall.dart';
import 'package:frontend/presentation/child_dashboard/dialogue_alert/viewSeekAssistanceCard_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class SeekAssistanceCardService {
  void onViewClick(BuildContext context, Object orgId) {
    ViewSeekAssistanceCard viewSeekAssistanceCard = ViewSeekAssistanceCard();
    Future<dynamic> organisationDataFuture =
        OrganisationApiCall.fetchOrganisationByIdApi(context, orgId);
    organisationDataFuture.then((value) =>
        {viewSeekAssistanceCard.viewSeekAssistanceCardDetail(context, value)});
  }

  void onContactOrganisationClick(String url) async {
    // Convert string URL to Uri
    try {
      Uri uri = Uri.parse(url);
      launch(url);
    } catch (e) {
      print("Could not launch $url. Some error occured: $e");
    }
  }
}
