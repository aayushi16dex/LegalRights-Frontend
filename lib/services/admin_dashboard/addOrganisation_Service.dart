import 'package:flutter/material.dart';
import 'package:frontend/api_call/organisation_api/organisation_apiCall.dart';
import 'package:frontend/model/organisation_controller.dart';
import 'package:frontend/presentation/confirmation_alert/signup_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';

class AddOrganisationService {
  static void postOrganisationData(BuildContext context,
      OrganisationFormController organisationFormController) {
    String orgShortName = '';
    String orgAbout =
        organisationFormController.organisationAboutController.text;
    String orgvision =
        organisationFormController.organisationVisionController.text;
    String orgMission =
        organisationFormController.organisationMissionController.text;
    Map<String, dynamic> orgData = {
      'organisationName':
          organisationFormController.organisationNameController.text,
      'shortName':
          'no name',
      'description': {
        'about': orgAbout,
        'vision': orgvision,
        'mission': orgMission
      },
      'websiteUrl':
          organisationFormController.organisationWebUrlController.text,
    };
    print(orgData);
    Future<int> statusCode = OrganisationApiCall.addOrganisationApi(context, orgData);
    print(statusCode);
    statusCode.then((value) => {
          orgShortName = orgData['shortName'],
          callConfirmationAlert(context, value, orgShortName)
        });

        print(statusCode);
  }

  static void callConfirmationAlert(
      BuildContext context, int statusCode, String orgName) {
    String errorMessage = '';
    String error = '';
    if (statusCode == 200) {
      SignupConfirmation.signUpConfirmationAlert(context, 'ADMIN');
    } else if (statusCode == 409) {
      errorMessage = 'Already Exists';
      error = '"$orgName" is already added earlier!!';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    } else {
      errorMessage = 'Error occured';
      error = '$orgName cannot be added.';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    }
  }
}
