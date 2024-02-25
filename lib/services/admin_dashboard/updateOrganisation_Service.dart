import 'package:flutter/material.dart';
import 'package:frontend/api_call/organisation_api/organisation_apiCall.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/update_confirmation.dart';

class UpdateOrganisationService {
  static void putOrganisationData(BuildContext context, Map updatedorgData,
      Object orgId, String orgShortName) {
    Future<int> statusCode = OrganisationApiCall.updateOrganisationApi(
        context, updatedorgData, orgId);
    statusCode
        .then((value) => {callConfirmationAlert(context, value, orgShortName)});

    print(statusCode);
  }

  static void callConfirmationAlert(
      BuildContext context, int statusCode, String orgShortName) {
    String errorMessage = '';
    String error = '';
    if (statusCode == 200) {
      UpdateConfirmationAlert.showUpdateConfirmationDialog(
          context, 'Organisation');
    } else {
      errorMessage = 'Error occured';
      error = '$orgShortName cannot be updated.';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    }
  }
}
