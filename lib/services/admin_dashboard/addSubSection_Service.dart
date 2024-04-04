import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalContent_api/addSubSection_api.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/success_confirmation.dart';

class AddSubSectionService {
  static void addSubSection(
      BuildContext context, String sectionId, Map<int, String> videoUrl) {
    Future<int> statusCode =
        AddSubSectionApi.addSubSection(sectionId, videoUrl);
    statusCode.then((value) => {callConfirmationAlert(context, value)});
  }

  static void callConfirmationAlert(
      BuildContext context, int statusCode) async {
    String errorMessage = '';
    String error = '';
    if (statusCode == 200) {
      String message = 'Sub-section added successfully';
      SuccessConfirmation.successConfirmationDialog(context, message);
      Future.delayed(const Duration(seconds: 3), () {
        
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
    } else if (statusCode == 500) {
      String error = 'Internal Server Error';
      String errorMessage = 'Try again after sometime';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    } else {
      errorMessage = 'Error occured';
      error = 'Sub-section cannot be added.';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    }
  }
}
