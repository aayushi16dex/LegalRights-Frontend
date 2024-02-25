import 'package:flutter/material.dart';
import 'package:frontend/services/admin_dashboard/changeStatus_Service.dart';

class ChangeStatusAlert {
  static void changeStatusAlert(BuildContext context, String id,
      String screenTypeName, bool currentStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(screenTypeName),
          content: const Text('Are you sure you want to change status?'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                ChangeStatusService.onchangeStatusClick(
                    context, id, screenTypeName, currentStatus);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: currentStatus
                    ? const Color.fromARGB(255, 168, 1, 26)
                    : Color.fromARGB(255, 1, 138, 29), // White text color
                minimumSize: const Size(120, 30), // Increase button size
              ),
              child: Text(
                currentStatus ? 'Deactivate' : 'Activate',
                style: const TextStyle(fontSize: 15), // Adjust text size
              ),
            ),
          ],
        );
      },
    );
  }
}
