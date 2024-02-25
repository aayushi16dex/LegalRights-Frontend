import 'package:flutter/material.dart';
import 'package:frontend/services/admin_dashboard/addOrganisation_Service.dart';
import 'package:frontend/model/organisation_controller.dart';

class AddOrganisationAlertForm {
  static void addOrganisationForm(BuildContext context, String buttonName) {
    OrganisationFormController orgController = OrganisationFormController();

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
                  const Text('Fill Organisation Details'),
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
                    controller: orgController.organisationNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: orgController.organisationShortNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Short Name',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: orgController.organisationWebUrlController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Website Url',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: orgController.organisationAboutController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'About',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: orgController.organisationVisionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Vision',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: orgController.organisationMissionController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mission',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          contentPadding: EdgeInsets.zero, // Remove default content padding
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  AddOrganisationService.postOrganisationData(
                      context, orgController);
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
