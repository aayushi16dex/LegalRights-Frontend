import 'package:flutter/material.dart';

class SectionSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'PressStart2P'),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          _buildCard(
            title: 'About this Section',
            points: [
              'In this section we studied about "Child Rights Against Exploitation" \nWe have discussed the importance of protecting children.',
              'We haver also explored legal frameworks in India.',
              'We have highlighted protective measures.',
            ],
          ),
          SizedBox(height: 16.0),
          _buildCard(
            title: 'Rights in Indian Constitution',
            points: [
              'Name: Child Rights Against Exploitation',
              'Article 23: Prohibition of traffic in human beings and forced labor.',
              'Article 24: Prohibition of employment of children in factories.',
              'Formed Year: Incorporated in the original Constitution in 1950.',
            ],
          ),
          SizedBox(height: 16.0),
          _buildCard(
            title: 'More Info',
            points: [
              'Aims to ensure that every child grows up in a safe, nurturing environment, free from exploitation and harm.',
              'Ensures protection against exploitation and ensures the right to education for children.',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required List<String> points}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: points.map((point) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        size: 16.0,
                        color: const Color.fromARGB(255, 4, 37, 97),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          point,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
