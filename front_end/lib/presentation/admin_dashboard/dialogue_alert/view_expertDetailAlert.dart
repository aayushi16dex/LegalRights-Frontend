import 'package:flutter/material.dart';
import 'package:frontend/presentation/admin_dashboard/widget/dialogue_alert/view_expertAlertDataWidget.dart';
import 'package:frontend/presentation/confirmation_alert/update_confirmation.dart';

class ViewExpertDetailAlert {
  static Future<void> viewExpertDetailAlert(
      BuildContext context, Map<String, dynamic> viewData) async {
    String firstName = viewData['firstName'];
    String lastName = '';
    if (viewData['lastName'] == null) {
      lastName = '';
    } else {
      lastName = viewData['lastName'];
    }
    String fullName = firstName + ' ' + lastName;
    String email = viewData['email'];
    int yrsExperience = viewData['experienceYears'];
    String professionName = viewData['profession']['professionName'];
    String stateName = viewData['state']['name'];
    List<dynamic> languageList = viewData['languagesKnown']
        .map((language) => language['languageName'] as String)
        .toList();
    List<dynamic> expertiseList = viewData['expertise']
        .map((expertise) => expertise['expertiseField'] as String)
        .toList();

    // Below code when update call will run
    // Map<String, dynamic> professionName = {
    //   'id': viewData['profession']['_id'] ?? '',
    //   'name': viewData['profession']['professionName'] ?? '',
    // };
    // Map<String, dynamic> stateName = {
    //   'id': viewData['state']['_id'] ?? '',
    //   'name': viewData['state']['name'] ?? '',
    // };
    // List<Map<String, dynamic>> languageList = [];
    // if (viewData['languagesKnown'] != null) {
    //   languageList = List<Map<String, dynamic>>.from(
    //     viewData['languagesKnown'].map((language) {
    //       return {
    //         'id': language['_id'] ?? '',
    //         'languageName': language['languageName'] ?? '',
    //       };
    //     }),
    //   );
    // }

    // List<Map<String, dynamic>> expertiseList = [];
    // if (viewData['expertise'] != null) {
    //   expertiseList = List<Map<String, dynamic>>.from(
    //     viewData['expertise'].map((item) {
    //       return {
    //         'id': item['_id'] ?? '',
    //         'expertiseName': item['expertiseField'] ?? '',
    //       };
    //     }),
    //   );
    // }

    bool isEditMode = false;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Center(
                  child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 4, 37, 97),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        'Legal Expert: $fullName',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                        'Email', email, !isEditMode, (value) {
                      setState(() {
                        email = value;
                      });
                    }),
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                        'Profession', professionName, !isEditMode, (value) {
                      setState(() {
                        firstName = value;
                      });
                    }),
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                        'Experience years', yrsExperience, !isEditMode,
                        (value) {
                      setState(() {
                        yrsExperience = value;
                      });
                    }),
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                        'State', stateName, !isEditMode, (value) {
                      setState(() {
                        firstName = value;
                      });
                    }),
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                        'Languages Known',
                        languageList,
                        !isEditMode,
                        (value) {}),
                    ViewExpertAlertDataWidget.viewExpertAlertDataWidget(
                        'Expertise Area',
                        expertiseList,
                        !isEditMode,
                        (value) {}),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(255, 4, 37, 97), // White text
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                    ),
                  ),
                  child: Text('Close'),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     setState(() {
                //       isEditMode = !isEditMode;
                //     });
                //   },
                //   child: Text(isEditMode ? 'Cancel update' : 'Edit'),
                // ),
                // if (isEditMode)
                //   ElevatedButton(
                //     onPressed: () {
                //       // Call your update API here
                //       // If update is successful, show confirmation dialog
                //       UpdateConfirmationAlert.showUpdateConfirmationDialog(
                //           context);
                //     },
                //     child: Text('Update'),
                //   ),
              ],
            );
          },
        );
      },
    );
  }
}
