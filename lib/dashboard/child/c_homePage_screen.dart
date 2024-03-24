import 'package:flutter/material.dart';
import 'package:frontend/api_call/section_api/section_apiCall.dart';
import 'package:frontend/presentation/child_dashboard/build_card/build_sectionContent.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int currentPage = 0;
  late Future<List<Map<String, dynamic>>> sectionListFuture;
  List<Map<String, dynamic>> sectionList = [];
  final BuildSectionCardBox buildSectionCard = BuildSectionCardBox();
  @override
  void initState() {
    super.initState();
    sectionListFuture = SectionApiCall.fetchSectionApi(context);
    sectionListFuture.then((result) {
      setState(() {
        sectionList = result;
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
            const SizedBox(height: 5),
            const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Play, Learn, Know Your Rights \n\t\t\t\t Fun with Legal Insights!',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 4, 37, 97),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 120, 124, 127),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Center(
                child: Text(
                  "Let's Start Learning",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Adjust text color
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: sectionListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for data, show a loading indicator
                    return Center(
                      child: CustomeCircularProgressBar
                          .customeCircularProgressBar(),
                    );
                  } else if (snapshot.hasError) {
                    // If an error occurs during the fetch, handle it here
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: sectionList.length,
                          itemBuilder: (context, index) {
                            return buildSectionCard.buildSectionCardBox(
                                sectionList[index], context);
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
