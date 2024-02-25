import 'package:flutter/material.dart';
import 'package:frontend/services/admin_dashboard/deleteOrganisation_Service.dart';

class DeleteOrgansationAlert {
  static void deleteOrgansationAlert(
      BuildContext context, String id, String screenTypeName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(screenTypeName),
          content: const Text('Are you sure you want to delete organisation?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                DeleteOrganisationService.onDeleteClick(
                    context, id, screenTypeName);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor:
                    const Color.fromARGB(255, 168, 1, 26), // White text color
                minimumSize: const Size(120, 30), // Increase button size
              ),
              child: const Text(
                'Delete',
                style: const TextStyle(fontSize: 15), // Adjust text size
              ),
            ),
          ],
        );
      },
    );
  }
}
