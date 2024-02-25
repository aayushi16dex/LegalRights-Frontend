import 'package:flutter/material.dart';

class ViewSeekAssistanceCard {
  void viewSeekAssistanceCardDetail(
      BuildContext context, Map<String, dynamic> viewData) async {
    String orgName = viewData['organisationName'];
    String orgAbout = viewData['description']['about'];
    String orgVision = viewData['description']['vision'];
    String orgMission = viewData['description']['mission'];

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
                        orgName,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ))),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5.0),
                        const Text(
                          'About:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors
                                  .black, // Add border for visual distinction
                            ),
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            orgAbout,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Mission:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Colors.black, // Add border for visual distinction
                        ),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        orgMission,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Vision:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              Colors.black, // Add border for visual distinction
                        ),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        orgVision,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
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
                    backgroundColor: const Color.fromARGB(255, 4, 37, 97),
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
