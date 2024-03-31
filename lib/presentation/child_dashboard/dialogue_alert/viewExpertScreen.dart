// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class ViewExpertDetailScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final int yrsExperience;
  final String professionName;
  final String stateName;
  final List<String> languageList;
  final List<String> expertiseList;

  const ViewExpertDetailScreen({
    Key? key,
    required this.fullName,
    required this.email,
    required this.yrsExperience,
    required this.professionName,
    required this.stateName,
    required this.languageList,
    required this.expertiseList,
  }) : super(key: key);

  @override
  _ViewExpertDetailScreenState createState() => _ViewExpertDetailScreenState();
}

class _ViewExpertDetailScreenState extends State<ViewExpertDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        title: Text(
          'Legal Expert: ${widget.fullName}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Email:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Profession:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget.professionName,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Years of Experience:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget.yrsExperience.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Languages Known',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget.languageList.join(', '),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Expertise Area',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget.expertiseList.join(', '),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'State',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget.stateName,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
