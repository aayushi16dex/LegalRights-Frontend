// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/presentation/child_dashboard/section_content/buildSectionContent1.dart';
import 'package:frontend/services/child_dashboard/sectionContent_Service.dart';

class SectionContentScreen extends StatefulWidget {
  final Map<String, dynamic> sectionData;

  SectionContentScreen(this.sectionData);

  @override
  _SectionContentScreenState createState() => _SectionContentScreenState();
}

class _SectionContentScreenState extends State<SectionContentScreen> {
  SubSectionContent1 subSectionContent = SubSectionContent1();
  Map<String, dynamic> get sectionData => widget.sectionData;
  SectionContentService sectionContentService = SectionContentService();
  late Future<Map<String, dynamic>> subSectionFuture;
  Map<String, dynamic> subSectionData = {};
  @override
  void initState() {
    super.initState();
    subSectionFuture = sectionContentService.getSectionContentById(
        sectionData['_id'], context);
    subSectionFuture.then((result) {
      setState(() {
        subSectionData = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Section ${sectionData['sectionNumber']}',
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
        body: subSectionData.isNotEmpty
            ?subSectionContent.buildSubSectionContent1(
                context, sectionData, subSectionData)
            : const Center(child: CircularProgressIndicator()));
  }
}
