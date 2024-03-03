// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/presentation/child_dashboard/section_content/buildSectionContent.dart';

class SectionContent extends StatelessWidget {
  final Map<String, dynamic> section;

  SectionContent(this.section);

  BuildSectionContent buildSectionContent = BuildSectionContent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Section ${section['sectionNumber']}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'PressStart2P'),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
      ),
      body: buildSectionContent.buildSectionContent(context, section),
    );
  }
}
