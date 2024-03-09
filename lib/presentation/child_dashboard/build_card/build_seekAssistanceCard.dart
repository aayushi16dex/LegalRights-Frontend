import 'package:flutter/material.dart';
import 'package:frontend/core/config.dart';
import 'package:frontend/presentation/child_dashboard/widget/addData_cardWidget.dart';
import 'package:frontend/services/child_dashboard/seekAssistanceCard_Service.dart';

class BuildSeekAssistanceCard {
  Widget buildSeekAssistanceCard(
      BuildContext context, Map<String, dynamic> data) {
    String orgName = data['organisationName'];
    if (data['shortName'] != null) {
      String shortName = data['shortName'];
      orgName = "$orgName ($shortName)";
    }
    String about = data['description']['about'];
    String webUrl = data['websiteUrl'];
    AddCardDataWidget addCardDataWidget = AddCardDataWidget();
    SeekAssistanceCardService seekAssistanceCardService =
        SeekAssistanceCardService();
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
                  padding:
                      EdgeInsets.all(10), // Add padding outside the container
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
                              '${AppConfig.baseUrl}/${data['organisationImage']}')
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
                      addCardDataWidget.addCardData(orgName, ''),
                      addCardDataWidget.addCardData('', about),
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
                      seekAssistanceCardService.onViewClick(
                          context, '${data['_id']}')
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 78, 77, 80),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('View Detail'),
                  ),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      seekAssistanceCardService
                          .onContactOrganisationClick(webUrl);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 22, 0, 95),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('Contact'),
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
