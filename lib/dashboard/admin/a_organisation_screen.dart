import 'package:flutter/material.dart';
import 'package:frontend/api_call/organisation_api/organisation_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/widget/buttons/build_addButton.dart';
import 'package:frontend/presentation/admin_dashboard/build_card/build_organisationCard.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';

class OrganisationScreen extends StatefulWidget {
  const OrganisationScreen({super.key});
  @override
  _OrganisationScreenState createState() => _OrganisationScreenState();
}

class _OrganisationScreenState extends State<OrganisationScreen> {
  late Future<List<Map<String, dynamic>>> orgListFuture;
  List<Map<String, dynamic>> orgList = [];
  int orgCount = 0;

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
            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildAddButton.buildAddButton(context, "Add Organisation"),
              ],
            ),

            const SizedBox(height: 15),
            // Title
            Text(
              'Total Organisations: $orgCount',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
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
                        child: Text('No Active Legal Expert Found'));
                  } else {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: orgList.length,
                      itemBuilder: (context, index) {
                        return BuildOrganisationCard.buildOrganisationCard(
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
