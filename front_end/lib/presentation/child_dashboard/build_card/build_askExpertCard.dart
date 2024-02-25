import 'package:flutter/material.dart';
import 'package:frontend/presentation/child_dashboard/dialogue_alert/askQuery_alert.dart';
import 'package:frontend/presentation/child_dashboard/widget/addData_cardWidget.dart';
import 'package:frontend/services/admin_dashboard/legalExpert_cardService.dart';
import 'package:frontend/presentation/admin_dashboard/widget/card_data/add_cardData.dart';

class BuildAskExpertCard {
  AskQueryFormALert askQueryFormALert = AskQueryFormALert();
  Widget buildAskExpertCard(BuildContext context, Map<String, dynamic> data) {
    AddCardDataWidget addCardDataWidget = AddCardDataWidget();
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
                      addCardDataWidget.addCardData('Name : ', fullName),
                      addCardDataWidget.addCardData(
                          '$professionName | ', yrsExperience),
                      addCardDataWidget.addCardData(
                          'Expertise Area - ', expertiseList),
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
                    onPressed: () {
                      askQueryFormALert.askQueryForm(context, '${data['_id']}');
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 125, 125, 116),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    child: const Text('Ask Query'),
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
