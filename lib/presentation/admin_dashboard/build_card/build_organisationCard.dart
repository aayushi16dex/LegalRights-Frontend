import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/deleteOrganisation_alert.dart';
import 'package:frontend/presentation/admin_dashboard/widget/card_data/add_cardData.dart';
import 'package:frontend/services/admin_dashboard/organisation_cardService.dart';

class BuildOrganisationCard {
  static Future<Widget> buildOrganisationCard(
      BuildContext context, Map<String, dynamic> data) async {
    String? cloudUrl;
    try {
      cloudUrl = dotenv.env['FETCH_IMAGE_URL'];
    } catch (e) {
      print(e);
    }

    String orgName = data['organisationName'];
    if (data['shortName'] != '') {
      String shortName = data['shortName'];
      orgName = "$orgName ($shortName)";
    }
    String about = data['description']['about'];

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: Color.fromARGB(255, 4, 37, 97),
            width: 1.5), // Border color and width
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                      10), // Add padding outside the container
                  child: Container(
                    decoration: data['organisationImage'] != ''
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.black,
                                width: 2), // Black border with width 2
                          )
                        : null, // No border if organisation image is not shown
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      backgroundImage: data['organisationImage'] != ''
                          ? NetworkImage(
                              '$cloudUrl/${data['organisationImage']}')
                          : null, // Set to null if image data is not present
                      child: data['organisationImage'] == ''
                          ? const Icon(
                              Icons.business,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null, // Show Icon if image data is not present
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddCardData.addCardData(orgName, ''),
                      AddCardData.addCardData('', about),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => {
                      BuildOrganisationCardService.onViewClick(
                          context, '${data['_id']}')
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 22, 0, 95),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('View Detail'),
                  ),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      DeleteOrgansationAlert.deleteOrgansationAlert(
                          context, '${data['_id']}', 'Organisation');
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 168, 1, 26),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('Delete'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
