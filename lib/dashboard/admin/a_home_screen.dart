// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api_call/homePage_api/admin_homePage_apiCall.dart';
import 'package:frontend/model/header_data.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late Future<Map<String, int>> countsFuture;
  HeaderData headerData = HeaderData();
  late String name = "";
  @override
  void initState() {
    name = "${headerData.getFirstName()} ${headerData.getLastName()}";
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
        'legalRightCount': map['legalRightCount'] ?? 0
      };
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching count: $e');
      }
      return {
        'userCount': 0,
        'legalExpertCount': 0,
        'organisationCount': 0,
        'legalRightCount': 0
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                  ],
                ),
              ),
              FutureBuilder<Map<String, int>>(
                future: countsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final userCount = snapshot.data!['userCount'];
                    final legalExpertCount = snapshot.data!['legalExpertCount'];
                    final organisationCount =
                        snapshot.data!['organisationCount'];
                    final legalRightCount = snapshot.data!['legalRightCount'];
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(200),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Welcome $name",
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 4, 37, 97),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Empower experts, manage insights. Navigate the legal landscape with ease!",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 4, 37, 97),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 30,
                                children: [
                                  itemDashboard(
                                      'Children: $userCount', Icons.person),
                                  itemDashboard(
                                    'Legal Experts: $legalExpertCount',
                                    Icons.people,
                                  ),
                                  itemDashboard(
                                    'Organisations : $organisationCount',
                                    Icons.house,
                                  ),
                                  itemDashboard(
                                    'Legal Rights: $legalRightCount',
                                    Icons.balance,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemDashboard(String title, IconData iconData) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 4, 37, 97),
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              selectionColor: Colors.white,
            ),
          ],
        ),
      );
}
