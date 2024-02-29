import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpert_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/widget/buttons/build_addButton.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';
import '../../presentation/admin_dashboard/build_card/build_legalExpertCard.dart';

class LegalExpertRoleScreen extends StatefulWidget {
  const LegalExpertRoleScreen({super.key});
  @override
  _LegalExpertRoleScreenState createState() => _LegalExpertRoleScreenState();
}

class _LegalExpertRoleScreenState extends State<LegalExpertRoleScreen> {
  late Future<List<Map<String, dynamic>>> expertListFuture;
  List<Map<String, dynamic>> expertList = [];
  int expertCount = 0;

  @override
  void initState() {
    super.initState();
    expertListFuture =
        LegalExpertApiCall.fetchLegalExpertListApiByAdmin(context);
    expertListFuture.then((result) {
      setState(() {
        expertList = result;
        expertCount = expertList.length;
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildAddButton.buildAddButton(context, "Add Legal Expert"),
                const SizedBox(width: 10),
                BuildAddButton.buildAddButton(context, "Add Language")
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildAddButton.buildAddButton(context, "Add Expertise"),
                const SizedBox(width: 10),
                BuildAddButton.buildAddButton(context, "Add Profession")
              ],
            ),
            const SizedBox(height: 10),
            // Title
            Text(
              'Total Legal Experts: $expertCount',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: expertListFuture,
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
                  } else if (expertList.isEmpty) {
                    return const Center(
                        child: Text('No Active Legal Expert Found'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: expertList.length,
                        itemBuilder: (context, index) {
                          return BuildLegalExpertCard.buildLegalExpertCard(
                            context,
                            expertList[index],
                          );
                        },
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
