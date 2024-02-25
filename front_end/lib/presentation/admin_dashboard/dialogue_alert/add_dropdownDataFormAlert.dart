import 'package:flutter/material.dart';
import 'package:frontend/services/admin_dashboard/dropDown_dataFormService.dart';

class AddDropDownDataAlertForm {
  static void addDropDownDataForm(BuildContext context, String dropDownName) {
    TextEditingController dropDownDataController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dropDownName),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      size: 30,
                      color: Color.fromARGB(255, 4, 37, 97),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25.0), // Adjust padding as needed

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: dropDownDataController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(), // Add border on all sides
                    ),
                  ),
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.zero, // Remove default content padding
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String dropDownData = dropDownDataController.text;
                  DropDownDataFormService.onAddPress(
                      context, dropDownName, dropDownData);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      const Color.fromARGB(255, 4, 37, 97), // White text color
                  minimumSize: const Size(120, 30), // Increase button size
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 15), // Adjust text size
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
