import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpertScreen_api.dart';

class LegalExpertAnsweredQueriesScreen extends StatefulWidget {
  @override
  _LegalExpertAnsweredQueriesScreenState createState() =>
      _LegalExpertAnsweredQueriesScreenState();
}

class _LegalExpertAnsweredQueriesScreenState
    extends State<LegalExpertAnsweredQueriesScreen> {
  late Future<List<Map<String, dynamic>>> answeredQueriesFuture;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAnsweredQueries();
  }

  Future<void> fetchAnsweredQueries() async {
    setState(() {
      isLoading = true;
    });

    try {
      answeredQueriesFuture =
          LegalExpertScreenApiCall.fetchAnsweredQueriesApi(context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Answered Queries',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'PressStart2P'),
          textAlign: TextAlign.center,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: answeredQueriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 4, 37, 97),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<Map<String, dynamic>> answeredQueries =
                    snapshot.data as List<Map<String, dynamic>>;

                if (answeredQueries.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/no data.gif',
                          height: 100.0,
                          width: 150.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                          child: Text(
                        'No Answered Queries',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 4, 37, 97),
                        ),
                      )),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: answeredQueries.length,
                  itemBuilder: (context, index) {
                    final String query = answeredQueries[index]['query'];
                    final String response = answeredQueries[index]['response'];
                    final String createdAt =
                        answeredQueries[index]['createdAt'];
                    final String updatedAt =
                        answeredQueries[index]['updatedAt'];

                    final formattedCreatedAt =
                        DateFormat('dd-MM-yyyy (hh:mm a)', 'en_US').format(
                      DateTime.parse(createdAt).toLocal(),
                    );

                    final formattedUpdatedAt =
                        DateFormat('dd-MM-yyyy (hh:mm a)', 'en_US').format(
                      DateTime.parse(updatedAt).toLocal(),
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Question ${index + 1}: $query',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Answer: $response',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 4, 37, 97),
                                ),
                              ),
                              Text('Asked At: $formattedCreatedAt'),
                              Text('Answered At: $formattedUpdatedAt'),
                              //Text('Asked by: $askedBy'),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                );
              }
            },
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 4, 37, 97),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
