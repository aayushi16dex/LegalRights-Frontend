import 'package:flutter/material.dart';
import 'package:frontend/presentation/child_dashboard/section_content/customShapePaint.dart';
import 'package:frontend/presentation/child_dashboard/section_content/videoDemo.dart';

class SubSectionContent {
  Widget buildSubSectionContent(BuildContext context,
      Map<String, dynamic> sectionData, Map<String, dynamic> subSectionData) {
    // dynamic totalUnit = sectionData['totalUnits'];
    dynamic totalUnit = 2;
    Map<String, dynamic> videoUrlList = {
      'Introduction Part 1': '${subSectionData["contentVideo1"]}',
      'Introduction Part 2': '${subSectionData["contentVideo2"]}'
    };

    List<String> videoTitle = videoUrlList.keys.toList();
    return Column(
      children: [
        // Top container with custom paint
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
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 1.5, // Height of the line
                width: double.infinity, // Width of the line
                color: Colors.white, // Color of the line
              ),
              const SizedBox(height: 5),
              Text(
                '${sectionData['summary']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < totalUnit; i++)
                  Column(
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
                                  builder: (context) => CustomVideoPlayer(
                                    title: videoTitle[i],
                                    videoUrl: videoUrlList[videoTitle[i]],
                                    unitNumber: i + 1,
                                  ),
                                ),
                              );
                            },
                            child: CustomPaint(
                              painter: CustomShapePainter(
                                isFacingLeft: i.isEven,
                                buttonName: 'Unit ${i + 1}',
                                linePaintColor: i.isEven
                                    ? const Color.fromARGB(255, 4, 37, 97)
                                    : const Color.fromARGB(255, 155, 146, 144),
                                smallCirclePaintColor: i.isEven
                                    ? const Color.fromARGB(255, 155, 146, 144)
                                    : const Color.fromARGB(255, 4, 37, 97),
                              ),
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
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.all(10.0),
        //   margin: const EdgeInsets.all(3),
        //   decoration: BoxDecoration(
        //     color: const Color.fromARGB(255, 4, 37, 97),
        //     borderRadius: BorderRadius.circular(5.0),
        //   ),
        //   child: Center(
        //     child: Text(
        //       '${section['title']}',
        //       style: const TextStyle(
        //         fontSize: 23,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
