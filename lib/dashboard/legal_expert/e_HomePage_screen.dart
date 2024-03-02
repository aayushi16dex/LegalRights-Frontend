import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpertScreen_api.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';
import 'package:frontend/services/expert_dashboard/buildQueryCard_service.dart';

class LegalExpertHomeScreen extends StatefulWidget {
  @override
  _LegalHomeScreenState createState() => _LegalHomeScreenState();
}

class _LegalHomeScreenState extends State<LegalExpertHomeScreen> {
  late Future<Map<String, int>> queriesCountFuture;
  late int totalQueries = 0;
  late int answeredQueries = 0;
  late int unansweredQueries = 0;

  @override
  void initState() {
    super.initState();
    queriesCountFuture = LegalExpertScreenApiCall.fetchQueriesCountApi(context);
    queriesCountFuture.then((result) {
      setState(() {
        totalQueries = result['totalQueries'] ?? 0;
        answeredQueries = result['answeredQueries'] ?? 0;
        unansweredQueries = result['unansweredQueries'] ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BuildQueryCardService buildQueryCardService = BuildQueryCardService();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 4, 37, 97),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Text(
                    'Welcome to Tiny Advocate',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Adjust text color
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tinyadvocate is here to empower the youngest minds with awareness about their rights and responsibilities."',
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            Color.fromARGB(255, 4, 37, 97), // Adjust text color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              FutureBuilder<Map<String, int>>(
                future: queriesCountFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // If data is still loading, you can show a loading indicator
                    return Center(
                      child: CustomeCircularProgressBar
                          .customeCircularProgressBar(),
                    );
                  } else if (snapshot.hasError) {
                    // If an error occurred while fetching data, display an error message
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            // color: Color.fromARGB(255, 121, 118, 118),
                            color: const Color.fromARGB(255, 120, 124, 127),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Queries: $totalQueries',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Answered Queries: $answeredQueries',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Unanswered Queries: $unansweredQueries',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              buildQueryCardService.getQueryScreenDetail(
                                  context, 1);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 4, 37, 97),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              fixedSize: const Size(double.infinity,
                                  50), // Adjust the height as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Adjust the border radius
                              ),
                            ),
                            child: const Text('View Answered Queries'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              buildQueryCardService.getQueryScreenDetail(
                                  context, 2);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 4, 37, 97),
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              fixedSize: const Size(double.infinity,
                                  50), // Adjust the height as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Adjust the border radius
                              ),
                            ),
                            child: const Text('View Unanswered Queries'),
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
}
