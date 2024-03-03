// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class AddSubSectionScreen extends StatefulWidget {
  const AddSubSectionScreen({super.key});

  @override
  _AddSubSectionScreenState createState() => _AddSubSectionScreenState();
}

class _AddSubSectionScreenState extends State<AddSubSectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void callAdminHomeScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.07;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add Sub Section',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: maxFontSize,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              callAdminHomeScreen(context);
            },
          ),
        ],
      ),
    );
  }
}
