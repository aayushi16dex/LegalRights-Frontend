import 'package:flutter/material.dart';
import 'package:frontend/core/config.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/deleteOrganisation_alert.dart';
import 'package:frontend/presentation/admin_dashboard/widget/card_data/add_cardData.dart';
import 'package:frontend/services/admin_dashboard/organisation_cardService.dart';

class BuildOrganisationCard {
  static Widget buildOrganisationCard(
      BuildContext context, Map<String, dynamic> data) {
    String orgName = data['organisationName'];
    String shortName = data['shortName'];
    String webUrl = data['websiteUrl'];
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
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  backgroundImage: data['displayPicture'] != null
                      ? NetworkImage(
                          '${AppConfig.baseUrl}/${data['displayPicture']}')
                      : null, // Set to null if image data is not present
                  child: data['displayPicture'] == null
                      ? const Icon(
                          Icons.business,
                          size: 50,
                          color: Colors.grey,
                        )
                      : null, // Show Icon if image data is not present
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddCardData.addCardData(shortName, ''),
                      AddCardData.addCardData(orgName, ''),
                      AddCardData.addCardData('Url: ', webUrl),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
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
