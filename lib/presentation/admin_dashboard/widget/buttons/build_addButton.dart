import 'package:flutter/material.dart';
import 'package:frontend/presentation/register/register_screen.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/add_dropdownDataFormAlert.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/add_organisationFormAlert.dart';
import 'package:frontend/services/admin_dashboard/addSection.dart';
import 'package:frontend/services/admin_dashboard/addVideoService.dart';

class BuildAddButton {
  static Widget buildAddButton(BuildContext context, String buttonName) {
    return Expanded(
      child: TextButton(
        onPressed: () => {
          if (buttonName == 'Add Legal Expert') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(
                  isAdmin: true,
                ),
              ),
            )
          } else if (buttonName == 'Add Language' ||
              buttonName == 'Add Expertise' ||
              buttonName == 'Add Profession') {
            AddDropDownDataAlertForm.addDropDownDataForm(context, buttonName)
          } else if (buttonName == 'Add Organisation') {
            AddOrganisationAlertForm.addOrganisationForm(context, buttonName)
          } else if (buttonName == 'Add Section') {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AddSection(),
                );
              },
            )
          } else if (buttonName == 'Add Video') {
            AddVideoService.pickVideo(context)
          }
        },
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: const Color.fromARGB(255, 4, 37, 97),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(15),
        ),
        child: Text(buttonName, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
