import 'package:flutter/material.dart';
import 'package:frontend/api_call/organisation_api/organisation_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/build_card/build_organisationCard.dart';
import 'package:frontend/presentation/child_dashboard/build_card/build_seekAssistanceCard.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';

class SeekAssistanceScreen extends StatefulWidget {
  const SeekAssistanceScreen({super.key});
  @override
  _SeekAssistanceScreenState createState() => _SeekAssistanceScreenState();
}

class _SeekAssistanceScreenState extends State<SeekAssistanceScreen> {
  late Future<List<Map<String, dynamic>>> orgListFuture;
  List<Map<String, dynamic>> orgList = [];
  int orgCount = 0;
  BuildSeekAssistanceCard buildSeekAssistanceCard = BuildSeekAssistanceCard();
  @override
  void initState() {
    super.initState();
    orgListFuture = OrganisationApiCall.fetchOrganisationListApi(context);
    orgListFuture.then((result) {
      setState(() {
        orgList = result;
        orgCount = orgList.length;
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 37, 97),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Center(
                  child: Text(
                'List of Available Organisations',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
            const SizedBox(height: 15),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: orgListFuture,
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
                  } else if (orgList.isEmpty) {
                    return const Center(
                        child: Text('No Available organisation Found'));
                  } else {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: orgList.length,
                      itemBuilder: (context, index) {
                        return buildSeekAssistanceCard.buildSeekAssistanceCard(
                          context,
                          orgList[index],
                        );
                      },
                    ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
