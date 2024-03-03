// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:frontend/api_call/legalContent_api/addSubSection_api.dart';
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double maxFontSize = screenWidth * 0.07;
    double containerWidth = screenWidth * 0.9;
    double buttonWidth = containerWidth * 0.7;

    return Scaffold(
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
                      for (int i = 0; i < 4; i++)
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
                                    'Video ${i + 1}:',
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
                                        String? path = await AddVideoService
                                            .pickVideo(context);
                                        if (path != null) {
                                          setState(() {
                                            videoPaths[i] = path;
                                            videoUploaded[i] = true;
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: videoUploaded[i]
                                            ? const Color.fromARGB(
                                                255, 4, 37, 97)
                                            : const Color.fromARGB(255, 129, 127, 127),
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
                                            fontSize:
                                                16),
                                      ),
                                    ),
                                  ),
                                  if (!videoUploaded[i] && showErrorMessages)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Please upload Video ${i + 1}',
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (videoPaths.any((path) => path == null)) {
                                setState(() {
                                  showErrorMessages = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please upload all videos'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                final sectionId = widget.sectionId;
                                AddSubSectionApi.addSubSection(
                                    sectionId, videoPaths);
                              }
                            }
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
                            'Submit',
                            style:
                                TextStyle(fontSize: 18),
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
    Navigator.pop(context);
  }
}
