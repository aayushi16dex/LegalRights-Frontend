import 'package:flutter/material.dart';
import 'package:frontend/api_call/section_api/section_apiCall.dart';

class SectionContentService {
  Future<Map<String, dynamic>> getSectionContentById(
      Object sectionId, BuildContext context) async {
    Map<String, dynamic> subSectionContent =
        await SectionApiCall.fetchSectionByIdApi(context, sectionId);
    return subSectionContent;
  }

  // Future<File> getVideoContentById(Object videoId) async {
  //   File subSectionVideo =
  //       await SectionApiCall.fetchSectionByIdApi(context, sectionId);
  //   return subSectionContent;
  // }
}
