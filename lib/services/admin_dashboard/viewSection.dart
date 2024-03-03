// ignore_for_file: library_private_types_in_public_api, file_names, unnecessary_const

import 'package:flutter/material.dart';
import 'package:frontend/api_call/section_api/section_apiCall.dart';
import 'package:frontend/services/admin_dashboard/detailSection.dart';

class ViewSection extends StatefulWidget {
  const ViewSection({super.key});

  @override
  _ViewSectionState createState() => _ViewSectionState();
}

class _ViewSectionState extends State<ViewSection> {
  late Future<List<Map<String, dynamic>>> sectionData;

  @override
  void initState() {
    super.initState();
    sectionData = SectionApiCall.fetchSectionApi(context);
  }

  void refreshSectionData() {
    setState(() {
      sectionData = SectionApiCall.fetchSectionApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Section View',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: sectionData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color.fromARGB(255, 4, 37, 97),
                ),
              ),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Sort the list based on Section Number in ascending order
            List<Map<String, dynamic>> sortedList = List.from(snapshot.data!);
            sortedList.sort(
                (a, b) => a['sectionNumber'].compareTo(b['sectionNumber']));

            return ListView.builder(
              itemCount: sortedList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> sectionData = sortedList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SectionDetailScreen(sectionData),
                      ),
                    );
                  },
                  child: Card(
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
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
