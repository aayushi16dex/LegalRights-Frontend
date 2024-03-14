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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 22, 0, 95), // Dark color for Cancel button
                    minimumSize: const Size(120, 30),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(width: 8), // Adjust the space between buttons
                ElevatedButton(
                  onPressed: () async {
                    ChangeStatusService.onchangeStatusClick(
                        context, id, screenTypeName, currentStatus);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: currentStatus
                        ? const Color.fromARGB(255, 168, 1, 26)
                        : const Color.fromARGB(255, 1, 138, 29),
                    minimumSize: const Size(120, 30),
                  ),
                  child: Text(
                    currentStatus ? 'Deactivate' : 'Activate',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
