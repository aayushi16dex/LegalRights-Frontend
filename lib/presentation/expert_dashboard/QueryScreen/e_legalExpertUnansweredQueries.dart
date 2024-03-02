// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/api_call/legalExpert_api/legalExpertScreen_api.dart';

class LegalExpertUnansweredQueriesScreen extends StatefulWidget {
  @override
  _LegalExpertUnansweredQueriesScreenState createState() =>
      _LegalExpertUnansweredQueriesScreenState();
}

class _LegalExpertUnansweredQueriesScreenState
    extends State<LegalExpertUnansweredQueriesScreen> {
  late Future<List<Map<String, dynamic>>> unansweredQueriesFuture;
  bool isLoading = false;
  int selectedQuestionIndex = -1;
  late String response = '';

  @override
  void initState() {
    super.initState();
    fetchUnansweredQueries();
  }

  Future<void> fetchUnansweredQueries() async {
    setState(() {
      isLoading = true;
    });

    try {
      unansweredQueriesFuture =
          LegalExpertScreenApiCall.fetchUnansweredQueriesApi(context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> answerQuery(String questionId, String response) async {
    if (response.trim().isEmpty) {
      print('Response cannot be empty.');
    } else {
      try {
        bool success = await LegalExpertScreenApiCall.answerQueryApi(
          context,
          questionId,
          response,
        );

        if (success) {
          // Show success pop-up
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Success',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 37, 97),
                  ),
                ),
                content: const Text('Query answered successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      setState(() {
                        selectedQuestionIndex = -1;
                      });
                      fetchUnansweredQueries(); // Refresh the screen
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 37, 97),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          // Show error pop-up
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Error',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                content: const Text('Failed to answer the query.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 37, 97),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        // The answerQueryApi function already handles error display
        print('Error answering the query: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int questionNumber = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Unanswered Queries',
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
            future: unansweredQueriesFuture,
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
                final List<Map<String, dynamic>> unansweredQueries =
                    snapshot.data as List<Map<String, dynamic>>;

                if (unansweredQueries.isEmpty) {
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
                        'No Unanswered Queries',
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
                  itemCount: unansweredQueries.length,
                  itemBuilder: (context, index) {
                    final String id = unansweredQueries[index]['_id'];
                    final String query = unansweredQueries[index]['query'];
                    final String askedBy = unansweredQueries[index]['askedBy'];
                    final String createdAt =
                        unansweredQueries[index]['createdAt'];

                    final formattedCreatedAt =
                        DateFormat('dd-MM-yyyy (hh:mm a)', 'en_US').format(
                      DateTime.parse(createdAt).toLocal(),
                    );

                    questionNumber++;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Question $questionNumber: $query',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Not answered till now.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Text('Asked At: $formattedCreatedAt'),
                              Text('Asked by: $askedBy'),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: selectedQuestionIndex == index,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                children: [
                                  TextField(
                                    maxLines: 3,
                                    onChanged: (value) {
                                      response = value;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your response...',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedQuestionIndex = -1;
                                          });
                                        },
                                        child: const Text('Cancel'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      ElevatedButton(
                                        onPressed: () {
                                          answerQuery(id, response);
                                        },
                                        child: const Text('Post Response'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 4, 37, 97),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (selectedQuestionIndex != index)
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedQuestionIndex = index;
                                  });
                                },
                                child: const Text('Answer Query'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 4, 37, 97),
                                ),
                              ),
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
