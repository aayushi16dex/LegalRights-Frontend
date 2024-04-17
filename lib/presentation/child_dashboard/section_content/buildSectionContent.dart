import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/presentation/child_dashboard/section_content/videoDemo.dart';
import 'package:frontend/presentation/child_dashboard/section_content/sectionSummary.dart';
import 'package:frontend/presentation/confirmation_alert/completion_confirmation.dart';

class SubSectionContent {
  Widget buildSubSectionContent(BuildContext context,
      Map<String, dynamic> sectionData, Map<String, dynamic> subSectionData) {
    var cloudVideoUrl = dotenv.env['FETCH_VIDEO_URL'];
    Map<String, dynamic> videoUrlList = {
      'Welcome To Session':
          '$cloudVideoUrl${subSectionData["introductionVideo"]}',
      'Content Part 1': '$cloudVideoUrl${subSectionData["contentVideo1"]}',
      'Content Part 2': '$cloudVideoUrl${subSectionData["contentVideo2"]}',
    };
    List<String> videoTitle = videoUrlList.keys.toList();
    final Map<int, IconData> lessonIcons = {
      1: Icons.keyboard_double_arrow_right_outlined,
      2: Icons.play_circle_filled,
      3: Icons.video_library,
      4:Icons.menu_book,
      5: Icons.emoji_events
    };
    int totalLessons = lessonIcons.length; // Total number of levels
    const int currentLevel = 40; // Current level or progress
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
                for (int index = 0; index < totalLessons; index++)
                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(5),
                          child: GestureDetector(
                            onTap: () {
                              if(index == 3)
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>   SectionSummaryScreen()
                                ),
                                );
                              if(index == 0 || index == 1 || index == 2)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CustomVideoPlayer(
                                      title: videoTitle[index],
                                      videoUrl: videoUrlList[videoTitle[index]],
                                      unitNumber: index + 1,
                                    ),
                                  ),
                                );
                              if(index == 4)
                                CompletionConfirmation.completionConfirmationAlert(context, sectionData['sectionNumber']);
                            },
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
                                        ? const Color.fromARGB(255, 18, 216, 25)
                                        : Colors.grey, // Incomplete level color
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
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
