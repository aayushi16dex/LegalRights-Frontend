import 'package:flutter/material.dart';
import 'package:frontend/api_call/dropdown_api/expertiseDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/languageDropdown_apiCall.dart';
import 'package:frontend/api_call/dropdown_api/professionDropdown_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/confirmation/dropdown_addConfirmation.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';

class DropDownDataFormService {
  static void onAddPress(
      BuildContext context, String dropDownName, String dropDownData) {
    late Future<int> value;
    print("Dropdown name is: $dropDownName");
    if (dropDownName == 'Add Profession') {
      value = ProfessionDropDownApi.addProfessionApi(context, dropDownData);
      value.then((int value) {
        addConfirmationStatus(context, value, dropDownName, dropDownData);
      });
    } else if (dropDownName == 'Add Expertise') {
      value = ExpertiseDropDownApi.addExpertiseApi(context, dropDownData);
      value.then((int value) {
        addConfirmationStatus(context, value, dropDownName, dropDownData);
      });
    } else if (dropDownName == 'Add Language') {
      value = LanguageDropDownApi.addLanguageApi(context, dropDownData);
      value.then((int value) {
        addConfirmationStatus(context, value, dropDownName, dropDownData);
      });
    } else {
      String errorMessage = 'Error occured';
      String error = 'Value cannot be added.';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    }
  }

  static void addConfirmationStatus(BuildContext context, int status,
      String dropDownName, String dropDownDataValue) {
    String errorMessage = '';
    String error = '';
    Navigator.of(context).pop();
    print("Status is: $status");
    if (status == 201) {
      AddDropDownConfirmation.addDropDownConfirmation(context, dropDownName);
    } else if (status == 409) {
      errorMessage = '$dropDownName Already Exists';
      error = '"$dropDownDataValue" is already added earlier!!';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    } else {
      errorMessage = 'Error occured';
      error = '$dropDownName cannot be added.';
      ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
    }
  }
}
