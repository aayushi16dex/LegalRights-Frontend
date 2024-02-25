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
    Uri uri = Uri.parse(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
