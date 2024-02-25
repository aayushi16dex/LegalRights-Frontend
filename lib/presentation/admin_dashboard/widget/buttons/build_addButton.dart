import 'package:flutter/material.dart';
import 'package:frontend/presentation/register/register_screen.dart';

import 'package:frontend/presentation/admin_dashboard/dialogue_alert/add_dropdownDataFormAlert.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/add_organisationFormAlert.dart';

class BuildAddButton {
  static Widget buildAddButton(BuildContext context, String buttonName) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => {
          if (buttonName == 'Legal Expert')
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpScreen(
                          isAdmin: true,
                        )),
              )
            }
          else if (buttonName == 'Language' ||
              buttonName == 'Expertise' ||
              buttonName == 'Profession')
            {AddDropDownDataAlertForm.addDropDownDataForm(context, buttonName)}
          else if (buttonName == 'Organisation')
            {AddOrganisationAlertForm.addOrganisationForm(context, buttonName)}
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 4, 37, 97), // White text
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
          ),
        ),
        child: Text('Add $buttonName', style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
