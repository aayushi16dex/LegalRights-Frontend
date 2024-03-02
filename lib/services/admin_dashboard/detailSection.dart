import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalContent_api/deleteSection.dart';
import 'package:frontend/services/admin_dashboard/viewSection.dart';

class SectionDetailScreen extends StatefulWidget {
  final Map<String, dynamic> sectionData;

  SectionDetailScreen(this.sectionData);

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
        duration: Duration(seconds: 3),
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
          title: Text(
            "Confirmation",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 4, 37, 97)),
          ),
          content: Text("Are you sure you want to delete this section?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Close the dialog and return false
              },
              child: Text(
                "No",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context)
                    .pop(true); // Close the dialog and return true
              },
              child: Text(
                "Yes",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
        // If the status code is 200, show the snackbar and pop the route
        showSnackBar('Section deleted successfully.');
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        // If there is an error or status code is not 200, display an error message
        showSnackBar('Failed to delete section. Status code: $statusCode');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.05;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Section Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: maxFontSize,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Show the confirmation dialog
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
      body: Padding(
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
                  primary: const Color.fromARGB(255, 4, 37, 97),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle adding a subsection
                },
                child: const Text(
                  'Add Sub Section',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
