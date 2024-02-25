import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpertScreen_api.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';
import 'package:frontend/presentation/expert_dashboard/homepage/buildCard.dart';

class LegalHomeScreen extends StatefulWidget {
  @override
  _LegalHomeScreenState createState() => _LegalHomeScreenState();
}

class _LegalHomeScreenState extends State<LegalHomeScreen> {
  late Future<Map<String, int>> queriesCountFuture;

  @override
  void initState() {
    super.initState();
    queriesCountFuture = LegalExpertScreenApiCall.fetchQueriesCountApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: queriesCountFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If data is still loading, you can show a loading indicator
          return Center(
            child: CustomeCircularProgressBar.customeCircularProgressBar(),
          );
        } else if (snapshot.hasError) {
          // If an error occurred while fetching data, display an error message
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // If data is available, display the information in a Column
          final data = snapshot.data as Map<String, int>;
          final totalQueries = data['totalQueries'] ?? 0;
          final answeredQueries = data['answeredQueries'] ?? 0;
          final unansweredQueries = data['unansweredQueries'] ?? 0;
          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2.0,
              children: [
                HomePageCard.buildCard('Children', totalQueries),
                HomePageCard.buildCard('Legal Experts', answeredQueries),
                HomePageCard.buildCard('Organizations', unansweredQueries),
              ],
            ),
          );
        }
      },
    );
  }
}
