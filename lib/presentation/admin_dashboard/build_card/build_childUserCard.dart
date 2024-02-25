import 'package:flutter/material.dart';
import 'package:frontend/presentation/admin_dashboard/widget/card_data/add_cardData.dart';

class BuildChildUserCard {
  static Widget buildChildUserCard(
      BuildContext context, Map<String, dynamic> data) {
    String fullName = '';
    String joinedDate = data['joinedOn'];
    String email = data['email'];
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
                      AddCardData.addCardData('Joined on : ', joinedDate),
                      AddCardData.addCardData('Email : ', email),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
