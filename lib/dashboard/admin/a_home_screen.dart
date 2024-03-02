import 'package:flutter/material.dart';
import 'package:frontend/presentation/admin_dashboard/widget/buttons/build_addButton.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';
import '../../api_call/homePage_api/admin_homePage_apiCall.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  //AdminHomePageLogic adminHomePageLogic = AdminHomePageLogic();
  late Future<Map<String, int>> countsFuture;
  @override
  void initState() {
    super.initState();
    countsFuture = fetchAdminHomePageCount(context);
  }

  Future<Map<String, int>> fetchAdminHomePageCount(BuildContext context) async {
    try {
      final adminHomePageLogic = HomePageApiCall();
      final map = await adminHomePageLogic.fetchCountApi(context);
      return {
        'userCount': map['userCount'] ?? 0,
        'legalExpertCount': map['expertCount'] ?? 0,
        'organisationCount': map['organisationCount'] ?? 0,
      };
    } catch (e) {
      print('Error fetching count: $e');
      return {
        'userCount': 0,
        'legalExpertCount': 0,
        'organisationCount': 0,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildAddButton.buildAddButton(context, 'Add Quiz'),
                const SizedBox(width: 2),
                BuildAddButton.buildAddButton(context, 'Add Section'),
                const SizedBox(width: 2),
                BuildAddButton.buildAddButton(context, 'View Section'),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder<Map<String, int>>(
                future: countsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CustomeCircularProgressBar
                          .customeCircularProgressBar(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final userCount = snapshot.data!['userCount'];
                    final legalExpertCount = snapshot.data!['legalExpertCount'];
                    final organisationCount =
                        snapshot.data!['organisationCount'];
                    return Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 2.0,
                        children: [
                          _buildCard('Children', userCount!),
                          _buildCard('Legal Experts', legalExpertCount!),
                          _buildCard('Organizations', organisationCount!),
                          _buildCard('Legal Rights', 5),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, int count) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 4, 37, 97), // Dark blue background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // White text
            ),
            const SizedBox(height: 5),
            Text(
              'Count: $count',
              style: const TextStyle(
                  fontSize: 16, color: Colors.white), // White text
            ),
          ],
        ),
      ),
    );
  }
}
