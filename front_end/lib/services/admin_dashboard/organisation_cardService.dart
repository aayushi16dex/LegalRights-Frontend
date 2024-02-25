import 'package:flutter/material.dart';
import 'package:frontend/api_call/organisation_api/organisation_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/view_organisationDetailAlert.dart';

class BuildOrganisationCardService {
  static void onViewClick(BuildContext context, String id) {
    Future<dynamic> organisationDataFuture =
        OrganisationApiCall.fetchOrganisationByIdApi(context, id);
    organisationDataFuture
        .then((value) => {callOrganisationDetailAlert(context, id, value)});
  }

  static dynamic callOrganisationDetailAlert(
      BuildContext context, String id, Map<String, dynamic> orgData) {
    return ViewOrganisationDetailAlert.viewOrganisationDetailAlert(
        context, orgData);
  }
}
