// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:frontend/presentation/child_dashboard/section_content/webView.dart';

class SubSectionContent1 {
  Widget buildSubSectionContent1(BuildContext context,
      Map<String, dynamic> sectionData, Map<String, dynamic> subSectionData) {
    Map<String, dynamic> videoUrlList = {
      'Introduction Part 1': '${subSectionData["contentVideo1"]}',
      'Introduction Part 2': '${subSectionData["contentVideo2"]}'
    };
    final Map<int, IconData> lessonIcons = {
      1: Icons.keyboard_double_arrow_right_outlined,
      2: Icons.menu_book,
      3: Icons.play_circle_filled,
      4: Icons.video_library,
      5: Icons.person_3,
      6: Icons.emoji_events
    };
    int totalLessons = lessonIcons.length; // Total number of levels
    const int currentLevel = 2; // Current level or progress
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 4, 37, 97),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${sectionData['title']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => CustomVideoPlayer(
                            //   title: videoTitle[i],
                            //   videoUrl: videoUrlList[videoTitle[i]],
                            //   unitNumber: i + 1,
                            // ),
                            builder: (context) => WebViewScreen(
                                // videoUrl: videoUrlList[videoTitle[i]],
                                ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            totalLessons,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15), // Adjust vertical spacing
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: index < currentLevel
                                                ? const Color.fromARGB(
                                                        255, 25, 159, 31)
                                                    .withOpacity(0.9)
                                                : const Color.fromARGB(
                                                        255, 122, 124, 122)
                                                    .withOpacity(
                                                        0.9), // Shadow color
                                            spreadRadius: 4, // Spread radius
                                            offset: const Offset(0,
                                                3), // Offset to control shadow direction
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 25.0, // Adjust circle size
                                        backgroundColor: index < currentLevel
                                            ? const Color.fromARGB(
                                                255, 18, 216, 25)
                                            : Colors
                                                .grey, // Incomplete level color
                                        child: Icon(
                                          lessonIcons.containsKey(index + 1)
                                              ? lessonIcons[index + 1]
                                              : Icons
                                                  .error, // Default icon if not found
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
