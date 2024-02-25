import 'package:flutter/material.dart';
import 'package:frontend/core/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../core/TokenManager.dart';

class MyQueryScreen extends StatefulWidget {
  const MyQueryScreen({Key? key}) : super(key: key);

  @override
  _MyQueryScreenState createState() => _MyQueryScreenState();
}

class _MyQueryScreenState extends State<MyQueryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> pastQueriesList = [];
  List<Map<String, dynamic>> expertList = [];
  String selectedExpertId = '';
  bool isProfileViewActive = false;
  bool isLoading = true;
  late TextEditingController queryController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
    fetchPastQueries();
    queryController = TextEditingController();
  }

  // code to delete
  Future<void> fetchData() async {
    try {
      final String expertfetch = AppConfig.fetchexperts;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(expertfetch), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('expertList')) {
          final List<dynamic> fetchedExpertList = data['expertList'];

          setState(() {
            expertList = fetchedExpertList.cast<Map<String, dynamic>>();
          });
        } else {
          print('Unexpected response format: $data');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> fetchPastQueries() async {
    try {
      setState(() {
        isLoading = true;
      });
      final String fetchUserQuery = AppConfig.fetchquery;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(fetchUserQuery), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('queryList')) {
          final List<dynamic> fetchedPastQueriesList = data['queryList'];

          setState(() {
            pastQueriesList =
                fetchedPastQueriesList.cast<Map<String, dynamic>>();
            isLoading = false;
          });
        } else {
          print('Unexpected response format: $data');
        }
      } else {
        throw Exception('Failed to load past queries');
      }
    } catch (error) {
      print('Error fetching past queries: $error');
    }
  }

  // code to delete
  Future<Map<String, dynamic>?> viewProfile(String expertId) async {
    try {
      final String profileUrl = '${AppConfig.fetchexperts}/$expertId';
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.get(Uri.parse(profileUrl), headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> profileData = json.decode(response.body);
        return profileData;
      } else {
        throw Exception('Failed to fetch profile data');
      }
    } catch (error) {
      print('Error fetching profile data: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _tabController.animateTo(0);
                      fetchPastQueries();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                      minimumSize: const Size(0, 40),
                    ),
                    child: const Text(
                      'Past Queries',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _tabController.animateTo(1);
                      setState(() {
                        isProfileViewActive = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                      minimumSize: const Size(0, 40),
                    ),
                    child: const Text(
                      'Ask Expert',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPastQueriesList(),
                // Ask Expert Tab Content
                isProfileViewActive
                    ? _buildDetailedProfileView()
                    : Container(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: expertList.length,
                          itemBuilder: (context, index) {
                            return _buildExpertFieldBox(expertList[index]);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastQueriesList() {
    return Stack(
      children: [
        ListView.builder(
          itemCount: pastQueriesList.length,
          itemBuilder: (context, index) {
            final pastQuery = pastQueriesList[index];
            final int questionNumber = index + 1;

            final formattedQuestionDate =
                DateFormat('dd-MM-yyyy (hh:mm a)', 'en_US')
                    .format(DateTime.parse(pastQuery['createdAt']).toLocal());

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    'Question $questionNumber: ${pastQuery['query']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pastQuery['answered']
                          ? Text(
                              'Answer: ${pastQuery['response']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 4, 37, 97),
                              ),
                            )
                          : const Text(
                              'Not answered till now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                      Text('Asked At: $formattedQuestionDate'),
                      if (pastQuery['answered']) ...[
                        Text(
                          'Answered At: ${DateFormat('dd-MM-yyyy (hh:mm a)', 'en_US').format(DateTime.parse(pastQuery['updatedAt']).toLocal())}',
                        ),
                      ],
                    ],
                  ),
                ),
                const Divider(),
              ],
            );
          },
        ),
        if (isLoading) // Show the loading indicator when data is still loading
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.fromARGB(255, 4, 37, 97), // Change the color as needed
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDetailedProfileView() {
    return FutureBuilder<Map<String, dynamic>?>(
      future: viewProfile(selectedExpertId),
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
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null) {
          return const Text('Profile data is null.');
        } else {
          Map<String, dynamic> profileData = snapshot.data!;

          return Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.account_circle,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${profileData['firstName']} ${profileData['lastName'] != null ? profileData['lastName'] : ''}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        '${profileData['profession']['professionName']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${profileData['country']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Member Since: ${profileData['joinedOn']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Expertise: ${profileData['expertise'].map((expertise) => expertise['expertiseField']).join(', ')}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: TextField(
                          controller: queryController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            border: InputBorder.none,
                            hintText: 'Write your query...',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 4, 37, 97),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              postQuery(
                                selectedExpertId,
                                queryController.text,
                              );
                            },
                            child: const Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 4, 37, 97),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> postQuery(String expertId, String query) async {
    try {
      if (expertId == '' || query == '') {
        print('Something is null');
        return;
      }
      final String postquery = AppConfig.postquery;
      final String authToken = await TokenManager.getAuthToken();
      final response = await http.post(
        Uri.parse(postquery),
        body: json.encode({
          'expertId': selectedExpertId,
          'query': query,
        }),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        _showQueryPostedDialog();
      } else {
        print('Failed to post query. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error posting query: $error');
    }
  }

  void _showQueryPostedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Query Posted Successfully',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 4, 37, 97),
            ),
          ),
          content: const Text('Your query has been posted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _switchToPastQueriesTab();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 37, 97)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _switchToPastQueriesTab() {
    _tabController.animateTo(0);
    fetchPastQueries();
  }

  Widget _buildExpertFieldBox(Map<String, dynamic> expert) {
    void onExpertSelected() {
      if (expert['_id'] != null) {
        viewProfile(expert['_id']);
        setState(() {
          selectedExpertId = expert['_id'];
          isProfileViewActive = true;
        });
      } else {
        print('Error: expertId is null');
      }
    }

    return GestureDetector(
      onTap: onExpertSelected,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                child: CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${expert['firstName']} ${expert['lastName'] != null ? expert['lastName'] : ''}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 37, 97)),
              ),
              Text('${expert['profession']['professionName']}'),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: TextButton(
                      onPressed: onExpertSelected,
                      child: const Text(
                        'View Profile',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
