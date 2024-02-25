import 'package:flutter/material.dart';
import 'package:frontend/api_call/organisation_api/organisation_apiCall.dart';
import 'package:frontend/presentation/confirmation_alert/delete_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';

class DeleteOrganisationService {
  static void onDeleteClick(
      BuildContext context, String id, String deleteName) async {
    int statusCodeValue =
        await OrganisationApiCall.deleteOrganisationApi(context, id);

    if (statusCodeValue != 0) {
      String errorMessage = '';
      String error = '';
      Navigator.of(context).pop();

      if (statusCodeValue == 200) {
        DeleteConfirmation.deleteConfirmationAlert(context, deleteName);
      } else if (statusCodeValue == 404) {
        errorMessage = 'Failed';
        error = 'No such Organisation exists!!';
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
      } else {
        errorMessage = 'Error occured';
        error = '$deleteName cannot be deleted.';
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
      }
    }
  }
}
