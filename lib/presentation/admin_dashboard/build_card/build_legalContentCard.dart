import 'package:flutter/material.dart';

class BuildLegalContentCard {
  static Widget buildLegalContentCard(
      BuildContext context, Map<String, dynamic> sectionData) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Section Number: ${sectionData['sectionNumber']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 37, 97),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Title: ${sectionData['title']}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total Units: ${sectionData['totalUnits']}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
