// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalContent_api/addSubSection_api.dart';
import 'package:frontend/presentation/confirmation_alert/completion_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/success_confirmation.dart';
import 'package:frontend/services/admin_dashboard/addSubSection_Service.dart';
import 'package:frontend/services/admin_dashboard/addVideoService.dart';
import 'package:frontend/services/admin_dashboard/addVideoService.dart';

class AddSubSectionScreen extends StatefulWidget {
  final String sectionId;

  const AddSubSectionScreen({required this.sectionId, Key? key})
      : super(key: key);

  @override
  _AddSubSectionScreenState createState() => _AddSubSectionScreenState();
}

class _AddSubSectionScreenState extends State<AddSubSectionScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String?> videoPaths = List.filled(4, null);
  List<bool> videoUploaded = List.filled(4, false);
  bool showErrorMessages = false;
  Map<int, String> video = {
    1: 'introductionVideo',
    2: 'contentVideo1',
    3: 'narratorVideo',
    4: 'contentVideo2'
  };

   Map<int, String> videoTitle = {
    1: 'Introduction Video',
    2: 'Content Video 1',
    3: 'Narrator Video',
    4: 'Content Video 2'
  };

  Map<int, String> videoUrl = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.07;
    double containerWidth = screenWidth * 0.9;
    double buttonWidth = containerWidth * 0.7;
    const int totalVideos = 4;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Sub Section',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: maxFontSize,
              color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set your desired color here
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 97),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < totalVideos; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: containerWidth,
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 4, 37, 97),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${videoTitle[i+1]}:',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 4, 37, 97),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        AddVideoService videoService =
                                            AddVideoService();
                                         String? videoPath = await videoService.addVideo(context);
                                           
                                        if (videoPath != null) {
                                          setState(() {
                                            videoUrl[i+1] = videoPath;
                                            videoUploaded[i] = true;
                                          });
                                        } else {
                                          print('Failed to select video.');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: videoUploaded[i]
                                            ? Color.fromRGBO(4, 37, 97, 1)
                                            : const Color.fromARGB(
                                                255, 129, 127, 127),
                                        elevation: 3,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 28),
                                        minimumSize: Size(buttonWidth, 0),
                                      ),
                                      child: Text(
                                        videoUploaded[i]
                                            ? 'Video Uploaded'
                                            : 'Upload Video',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {                           
                                final sectionId = widget.sectionId;
                                AddSubSectionService.addSubSection(context, sectionId, videoUrl);                         
                                // callAdminHomeScreen(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 4, 37, 97),
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            minimumSize: Size(buttonWidth, 0),
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callAdminHomeScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
