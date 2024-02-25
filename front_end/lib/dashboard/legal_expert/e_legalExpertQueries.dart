import 'package:flutter/material.dart';
import 'package:frontend/dashboard/legal_expert/e_legalExpertAnsweredQueries.dart';
import 'package:frontend/dashboard/legal_expert/e_legalExpertUnansweredQueries.dart';

class LegalExpertQueriesScreen extends StatefulWidget {
  @override
  _LegalExpertQueriesScreenState createState() =>
      _LegalExpertQueriesScreenState();
}

class _LegalExpertQueriesScreenState extends State<LegalExpertQueriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          // Customize the app bar color
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 2), // Add space above the tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTab('Unanswered Queries', 0),
                    _buildTab('Answered Queries', 1),
                  ],
                ),
                SizedBox(height: 2), // Add space below the tabs
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LegalExpertUnansweredQueriesScreen(),
          LegalExpertAnsweredQueriesScreen(),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int tabIndex) {
    return InkWell(
      onTap: () {
        _tabController.animateTo(tabIndex);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              Color.fromARGB(255, 4, 37, 97), // Customize the tab button color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
