import 'package:flutter/material.dart';
import 'package:frontend/services/child_dashboard/postQuery_Service.dart';

class AskQueryFormALert {
  void askQueryForm(BuildContext context, Object expertId) {
    TextEditingController askQueryController = TextEditingController();
    PostQueryService postQueryService = PostQueryService();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      size: 30,
                      color: Color.fromARGB(255, 4, 37, 97),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
          content: Container(
            child: TextFormField(
              controller: askQueryController,
              maxLines: null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                hintText: 'Write your query...',
              ),
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  postQueryService.postQueryData(
                      context, askQueryController, expertId);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 4, 37, 97),
                ),
                child: const Text(
                  'Post Query',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
