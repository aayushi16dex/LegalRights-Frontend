import 'package:flutter/material.dart';
import 'package:frontend/presentation/admin_dashboard/widget/dialogue_alert/view_organisationAlertDataWidget.dart';
import 'package:frontend/services/admin_dashboard/updateOrganisation_Service.dart';

class ViewOrganisationDetailAlert {
  static Future<void> viewOrganisationDetailAlert(
      BuildContext context, Map<String, dynamic> viewData) async {
    String orgId = viewData['_id'];
    String orgName = viewData['organisationName'];
    String orgAbout = viewData['description']['about'];
    String orgVision = viewData['description']['vision'];
    String orgMission = viewData['description']['mission'];
    String shortName;
    if (viewData['shortName'] == null){
      shortName = '';
    }
    else{
      shortName = viewData['shortName'];
    }
    
    String webUrl = viewData['websiteUrl'];
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
                        isEditMode ? 'Update Organisation Details' : orgName,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isEditMode)
                      const Text(
                        'Organisation Name:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    if (isEditMode) const SizedBox(height: 1),
                    if (isEditMode)
                      ViewOrganisationAlertDataWidget
                          .viewOrganisationAlertDataWidget(orgName, isEditMode,
                              (value) {
                        setState(() {
                          orgName = value;
                        });
                      }),
                    if (isEditMode) const SizedBox(height: 10),
                    if (isEditMode)
                      const Text(
                        'Organisation Short Name:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    if (isEditMode) const SizedBox(height: 1),
                    if (isEditMode)
                      ViewOrganisationAlertDataWidget
                          .viewOrganisationAlertDataWidget(
                              shortName, isEditMode, (value) {
                        setState(() {
                          shortName = value;
                        });
                      }),
                    if (isEditMode) const SizedBox(height: 10),
                    if (isEditMode)
                      const Text(
                        'Organisation Url:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    const SizedBox(height: 1),
                    if (isEditMode)
                      ViewOrganisationAlertDataWidget
                          .viewOrganisationAlertDataWidget(webUrl, !isEditMode,
                              (value) {
                        setState(() {
                          webUrl = value;
                        });
                      }),
                    if (isEditMode) const SizedBox(height: 10),
                    const Text(
                      'About:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 1),
                    ViewOrganisationAlertDataWidget
                        .viewOrganisationAlertDataWidget(orgAbout, !isEditMode,
                            (value) {
                      setState(() {
                        orgAbout = value;
                      });
                    }),
                    const SizedBox(height: 10),
                    const Text(
                      'Mission:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 1),
                    ViewOrganisationAlertDataWidget
                        .viewOrganisationAlertDataWidget(
                            orgMission, !isEditMode, (value) {
                      setState(() {
                        orgMission = value;
                      });
                    }),
                    const SizedBox(height: 10),
                    const Text(
                      'Vision:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 1),
                    ViewOrganisationAlertDataWidget
                        .viewOrganisationAlertDataWidget(orgVision, !isEditMode,
                            (value) {
                      setState(() {
                        orgVision = value;

                      });
                    })
                  ],
                ),
              ),
              actions: <Widget>[
                if (!isEditMode)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 168, 1, 26),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: !isEditMode
                        ? const Color.fromARGB(255, 4, 37, 97)
                        : const Color.fromARGB(255, 168, 1, 26),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Rounded corners
                    ),
                  ),
                  child: Text(isEditMode ? 'Close' : 'Edit Details'),
                ),
                if (isEditMode)
                  ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> updatedorgData = {
                        'id': orgId,
                        'description': {
                          'about': orgAbout,
                          'vision': orgVision,
                          'mission': orgMission
                        },
                        'websiteUrl': webUrl
                      };

                      UpdateOrganisationService.putOrganisationData(
                          context, updatedorgData, orgId, shortName);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                    ),
                    child: const Text('Update Detail'),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
