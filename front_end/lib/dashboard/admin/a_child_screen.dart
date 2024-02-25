import 'package:flutter/material.dart';
import 'package:frontend/api_call/userChild_api/fetchChild_apiCall.dart';
import 'package:frontend/presentation/admin_dashboard/build_card/build_childUserCard.dart';
import 'package:frontend/presentation/admin_dashboard/widget/buttons/build_addButton.dart';
import 'package:frontend/presentation/common/circular_progressBar.dart';

class ChildRoleScreen extends StatefulWidget {
  const ChildRoleScreen({super.key});
  @override
  _ChildRoleScreenState createState() => _ChildRoleScreenState();
}

class _ChildRoleScreenState extends State<ChildRoleScreen> {
  late Future<List<Map<String, dynamic>>> childListFuture;
  List<Map<String, dynamic>> childList = [];
  int childCount = 0;

  @override
  void initState() {
    super.initState();
    childListFuture = FetchChildApiCall.fetchChildListApi(context);
    childListFuture.then((result) {
      setState(() {
        childList = result;
        childCount = childList.length;
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
                'Total Children: $childCount',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),

            const SizedBox(height: 10),
            // Title

            const SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
                future: childListFuture,
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
                        itemCount: childList.length,
                        itemBuilder: (context, index) {
                          return BuildChildUserCard.buildChildUserCard(
                            context,
                            childList[index],
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
