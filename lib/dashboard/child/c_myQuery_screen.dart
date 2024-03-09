import 'package:flutter/material.dart';
import 'package:frontend/api_call/childUser_api/myQueriesApi/myQueries_api.dart';
import 'package:frontend/presentation/child_dashboard/build_card/build_myQueriesCard.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';

class MyQueryScreen extends StatefulWidget {
  const MyQueryScreen({Key? key}) : super(key: key);

  @override
  _MyQueryScreenState createState() => _MyQueryScreenState();
}

class _MyQueryScreenState extends State<MyQueryScreen> {
  late Future<List<Map<String, dynamic>>> queryListFuture;
  List<Map<String, dynamic>> pastQueriesList = [];
  late int totalQueries = 0;
  MyQueriesApi myQueriesApi = MyQueriesApi();
  BuildMyQueriesCard buildMyQueriesCard = BuildMyQueriesCard();
  @override
  void initState() {
    super.initState();
    queryListFuture = myQueriesApi.fetchChildQueriesApi(context);
    queryListFuture.then((result) {
      setState(() {
        pastQueriesList = result;
        totalQueries = pastQueriesList.length;
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
                color: const Color.fromARGB(255, 4, 37, 97),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                  child: Text(
                'Total Queries: $totalQueries',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: queryListFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CustomeCircularProgressBar
                          .customeCircularProgressBar(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    if (pastQueriesList.isEmpty) {
                      return const Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No Queries Asked.',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 4, 37, 97),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: pastQueriesList.length,
                          itemBuilder: (context, index) {
                            return buildMyQueriesCard.buildMyQueriesCard(
                                context, pastQueriesList[index], index + 1);
                          },
                        ),
                      );
                    }
                  }
                })
          ],
        ),
      ),
    );
  }
}
