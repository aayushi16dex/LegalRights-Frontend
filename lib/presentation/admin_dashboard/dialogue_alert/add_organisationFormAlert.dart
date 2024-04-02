import 'package:flutter/material.dart';
import 'package:frontend/services/admin_dashboard/addImageService.dart';
import 'package:frontend/services/admin_dashboard/addOrganisation_Service.dart';
import 'package:frontend/model/organisation_controller.dart';

class AddOrganisationAlertForm extends StatefulWidget {
  @override
  _AddOrganisationAlertFormState createState() =>
      _AddOrganisationAlertFormState();
}

class _AddOrganisationAlertFormState extends State<AddOrganisationAlertForm> {
  OrganisationFormController orgController = OrganisationFormController();
  String? organisationImage;

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Fill Organisation Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                  size: 25,
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              TextFormField(
                controller: orgController.organisationNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: orgController.organisationShortNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Short Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: orgController.organisationWebUrlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Website Url',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: orgController.organisationAboutController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'About',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: orgController.organisationVisionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Vision',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: orgController.organisationMissionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mission',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        AddImageService imageService = AddImageService();
                        String? imagePath = await imageService.addImage(context);
                        if (imagePath != null) {
                          setState(() {
                            organisationImage = imagePath;
                          });
                          print('Image selected successfully.');
                        } else {
                          print('Failed to select image.');
                        }
                      },
                      icon: const Icon(Icons.upload),
                      label: Text(
                        organisationImage != null ? 'Uploaded' : 'Upload Image',
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: organisationImage != null
                              ? Colors.green
                              : Color.fromARGB(255, 135, 139, 142),
                          foregroundColor: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () async {
              AddOrganisationService.postOrganisationData(
                  context, orgController, organisationImage!);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 4, 37, 97),
              minimumSize: const Size(120, 30),
              textStyle: TextStyle(fontSize: fontSize),
            ),
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }
}
