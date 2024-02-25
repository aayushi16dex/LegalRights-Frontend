import 'package:flutter/material.dart';
import 'package:frontend/presentation/admin_dashboard/widget/dialogue_alert/view_childUserAlertDataWidget.dart';

class ViewChildUserDetailAlert {
  static Future<void> viewChildUserDetailAlert(
      BuildContext context, Map<String, dynamic> viewData) async {
    String fullName = '';
    String firstName = viewData['firstName'];
    String lastName = viewData['lastName'];
    String joinedDate = viewData['joinedOn'];
    String email = viewData['email'];
    if (viewData['lastName'] == null) {
      fullName = viewData['firstName'];
    } else {
      fullName = viewData['firstName'] + ' ' + viewData['lastName'];
    }
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
                        fullName,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FirstName:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    ViewChildUserAlertDataWidget.viewChildUserAlertDataWidget(
                        firstName),
                    const SizedBox(height: 10),
                    const Text(
                      'LastName:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    ViewChildUserAlertDataWidget.viewChildUserAlertDataWidget(
                        lastName),
                    const SizedBox(height: 10),
                    const Text(
                      'Email:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    ViewChildUserAlertDataWidget.viewChildUserAlertDataWidget(
                        email),
                    const SizedBox(height: 10),
                    const Text(
                      'Joining Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    ViewChildUserAlertDataWidget.viewChildUserAlertDataWidget(
                        joinedDate),
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
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
