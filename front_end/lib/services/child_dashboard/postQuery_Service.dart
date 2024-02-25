import 'package:flutter/material.dart';
import 'package:frontend/api_call/childUser_api/myQueriesApi/myQueries_api.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/postQuery_confirmation..dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';

class PostQueryService {
   String errorMessage = '';
    String error = '';
  void postQueryData(BuildContext context,
      TextEditingController queryDataController, Object expertId) {
    MyQueriesApi myQueriesApi = MyQueriesApi();
    String queryData = queryDataController.text;
    if (queryData == ''){
        errorMessage = 'Query is empty!';
        error = 'Kindly write a query before posting';
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    }
    else{
      Future<int> statusCode = myQueriesApi.postQueryApiCall(expertId, queryData);
      statusCode.then((value) => {callConfirmationAlert(context, value)});
    }
  }

  void callConfirmationAlert(BuildContext context, int statusCode) {
    PostQueryconfirmation postQueryconfirmation = PostQueryconfirmation();
    if (statusCode == 200) {
      postQueryconfirmation.postQueryConfirmationAlert(context);
    } else {
      errorMessage = 'Error occured';
      error = '';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    }
  }
}
