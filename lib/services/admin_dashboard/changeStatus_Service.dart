import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpert_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/confirmation/changeStatus_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';

class ChangeStatusService {
  static void onchangeStatusClick(BuildContext context, String id,
      String screenTypeName, bool currentStatus) async {
    int statusCodeValue = 0;
    if (screenTypeName == 'Legal Expert') {
      statusCodeValue =
          await LegalExpertApiCall.changeExpertStatusApi(context, id);
    }
    if (statusCodeValue != 0) {
      changeStatusConfirmation(
          context, statusCodeValue, screenTypeName, currentStatus);
    }
  }

  static void changeStatusConfirmation(BuildContext context, int statusCode,
      String deleteName, bool currentStatus) {
    String errorMessage = '';
    String error = '';
    Navigator.of(context).pop();
    if (deleteName == 'Legal Expert') {
      if (statusCode == 200) {
        ChangeStatusConfirmation.changeStatusConfirmation(
            context, deleteName, currentStatus);
      } else if (statusCode == 401) {
        errorMessage = 'Failed';
        error = 'No such legal expert exists!!';
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
      } else {
        errorMessage = 'Error occured';
        error = '$deleteName cannot be deleted.';
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
      }
    }
  }
}
