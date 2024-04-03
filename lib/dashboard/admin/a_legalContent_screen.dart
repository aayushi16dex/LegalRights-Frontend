import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/api_call/section_api/section_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/build_card/build_legalContentCard.dart';
import 'package:frontend/presentation/admin_dashboard/widget/buttons/build_addButton.dart';
import 'package:frontend/services/admin_dashboard/detailSection.dart';

class LegalContentScreen extends StatefulWidget {
  const LegalContentScreen({Key? key}) : super(key: key);

  @override
  _LegalContentScreenState createState() => _LegalContentScreenState();
}

class _LegalContentScreenState extends State<LegalContentScreen> {
  late Future<List<Map<String, dynamic>>> sectionData;
  int legalContentCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    sectionData = SectionApiCall.fetchSectionApi(context);
    sectionData.then((value) {
      setState(() {
        legalContentCount = value.length;
      });
    });
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      refreshSectionData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void refreshSectionData() {
    setState(() {
      sectionData = SectionApiCall.fetchSectionApi(context);
      sectionData.then((value) {
        legalContentCount = value.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildAddButton.buildAddButton(context, "Add Legal Content"),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Total Legal Rights: $legalContentCount',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            FutureBuilder(
              future: sectionData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    legalContentCount == 0) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> sortedList =
                      List.from(snapshot.data!);
                  sortedList.sort((a, b) =>
                      a['sectionNumber'].compareTo(b['sectionNumber']));
                  return Expanded(
                    child: ListView.builder(
                      itemCount: sortedList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> sectionData = sortedList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SectionDetailScreen(sectionData),
                              ),
                            );
                          },
                          child: BuildLegalContentCard.buildLegalContentCard(
                              context, sectionData),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
