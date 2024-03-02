import 'package:flutter/material.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:frontend/presentation/expert_dashboard/QueryScreen/e_legalExpertAnsweredQueries.dart';
import 'package:frontend/presentation/expert_dashboard/QueryScreen/e_legalExpertUnansweredQueries.dart';

class BuildQueryCardService {
  void getQueryScreenDetail(BuildContext context, int queryTypeIndex) {
    if (queryTypeIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LegalExpertAnsweredQueriesScreen(),
        ),
      );
    } else if (queryTypeIndex == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LegalExpertUnansweredQueriesScreen(),
        ),
      );
    } else {
      String errorMessage = "Error Occured";
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, '');
    }
  }
}
