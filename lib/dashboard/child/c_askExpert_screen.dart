import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpert_apiCall.dart';
import 'package:frontend/presentation/child_dashboard/build_card/build_askExpertCard.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';

class AskExpertScreen extends StatefulWidget {
  const AskExpertScreen({super.key});
  @override
  _AskExpertScreenState createState() => _AskExpertScreenState();
}

class _AskExpertScreenState extends State<AskExpertScreen> {
  late Future<List<Map<String, dynamic>>> expertListFuture;
  BuildAskExpertCard buildAskExpertCard = BuildAskExpertCard();
  List<Map<String, dynamic>> expertList = [];
  int expertCount = 0;

  @override
  void initState() {
    super.initState();
    expertListFuture =
        LegalExpertApiCall.fetchLegalExpertListApiByUser(context);
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
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 4, 37, 97),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                  child: Text(
                'Total Experts: $expertCount',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
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
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: expertList.length,
                        itemBuilder: (context, index) {
                          return buildAskExpertCard.buildAskExpertCard(
                              context, expertList[index]);
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
