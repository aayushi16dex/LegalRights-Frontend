// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalContent_api/deleteSectionApi.dart';
import 'package:frontend/presentation/child_dashboard/confirmation_alert/deleteSectionConfirmation.dart';
import 'package:frontend/services/admin_dashboard/addSubSection.dart';

class SectionDetailScreen extends StatefulWidget {
  final Map<String, dynamic> sectionData;

  const SectionDetailScreen(this.sectionData, {super.key});

  @override
  _SectionDetailScreenState createState() => _SectionDetailScreenState();
}

class _SectionDetailScreenState extends State<SectionDetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void callAdminHomeScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildDetailItem(String label, dynamic value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$value',
          style: TextStyle(fontSize: 18, color: Colors.grey[800]),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void showDeleteConfirmationDialog(String sectionId) async {
    bool shouldPop = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirmation",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 4, 37, 97)),
          ),
          content: const Text("Are you sure you want to delete this section?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "No",
                style: TextStyle(
                    color: Color.fromARGB(255, 4, 37, 97),
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                "Yes",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );

    if (shouldPop == true) {
      int? statusCode =
          await DeleteSectionApi.deleteSection(context, sectionId);
      if (statusCode == 200) {
        DeleteSectionconfirmation deleteSectionconfirmation = DeleteSectionconfirmation();
        deleteSectionconfirmation.deleteSectionConfirmationAlert(context);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else {
        showSnackBar('Failed to delete section. Status code: $statusCode');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.07;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Section Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: maxFontSize,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDeleteConfirmationDialog(widget.sectionData['_id']);
            },
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              callAdminHomeScreen(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem(
                  'Section Number', widget.sectionData['sectionNumber']),
              _buildDetailItem('Title', widget.sectionData['title']),
              _buildDetailItem('Total Units', widget.sectionData['totalUnits']),
              _buildDetailItem('Sub Title', widget.sectionData['subTitle']),
              _buildDetailItem('Summary', widget.sectionData['summary']),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: false,
                    child: Text('ID: ${widget.sectionData['_id']}'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSubSectionScreen(
                          sectionId: widget.sectionData['_id'],
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Add Sub Section',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
