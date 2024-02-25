import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildMyQueriesCard {
  Widget buildMyQueriesCard(
      BuildContext context, Map<String, dynamic> data, int quesNo) {
    final formattedQuestionDate = DateFormat('dd-MM-yyyy (hh:mm a)', 'en_US')
        .format(DateTime.parse(data['createdAt']).toLocal());
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 2, // Add elevation for a card-like appearance
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
              color: Color.fromARGB(255, 4, 37, 97),
              width: 1.5), // Border color and width
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question $quesNo:',
                style: const TextStyle(
                  color: Color.fromARGB(255, 4, 37, 97),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                  height:
                      3), // Add some spacing between the question number and the query
              Text(
                '${data['query']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              data['answered']
                  ? Text(
                      'Answer: ${data['response']}',
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
              const SizedBox(
                  height:
                      5), // Add spacing between answer status and other details
              Text('Asked At: $formattedQuestionDate'),
              if (data['answered']) ...[
                Text(
                  'Answered At: ${DateFormat('dd-MM-yyyy (hh:mm a)', 'en_US').format(DateTime.parse(data['updatedAt']).toLocal())}',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
