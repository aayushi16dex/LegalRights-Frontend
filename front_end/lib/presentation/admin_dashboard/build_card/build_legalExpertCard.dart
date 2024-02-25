import 'package:flutter/material.dart';
import 'package:frontend/services/admin_dashboard/legalExpert_cardService.dart';
import 'package:frontend/presentation/admin_dashboard/widget/card_data/add_cardData.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/changeStatus_alert.dart';

class BuildLegalExpertCard {
  static Widget buildLegalExpertCard(
      BuildContext context, Map<String, dynamic> data) {
    bool status = data['active'];
    String fullName = '';
    String yrsExperience = "${data['experienceYears']}+ yrs";
    String professionName = data['profession']['professionName'];
    List<dynamic> fetchedexpertiseList = data['expertise']
        .map((expertise) => expertise['expertiseField'])
        .toList();
    String expertiseList = fetchedexpertiseList.join(', ');
    if (data['lastName'] == null) {
      fullName = data['firstName'];
    } else {
      fullName = data['firstName'] + ' ' + data['lastName'];
    }
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
                const Icon(Icons.person,
                    size: 50, color: Color.fromARGB(255, 125, 125, 116)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddCardData.addCardData('Name : ', fullName),
                      AddCardData.addCardData(
                          '$professionName | ', yrsExperience),
                      AddCardData.addCardData(
                          'Expertise Area - ', expertiseList),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      status ? 'Active' : 'Inactive',
                      style: TextStyle(
                          color: status ? Colors.green : Colors.red,
                          fontSize: 12),
                    )
                  ],
                )
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
                      BuildLegalExpertCardService.onViewClick(
                          context, '${data['_id']}')
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      ChangeStatusAlert.changeStatusAlert(
                          context, '${data['_id']}', 'Legal Expert', status);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: status
                            ? Color.fromARGB(255, 1, 138, 29)
                            : const Color.fromARGB(255, 168, 1, 26),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('Change Status'),
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
