import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/presentation/child_dashboard/section%20content/sectionContent_screen.dart';

class BuildSectionCardBox {
  // Function to build a round-cornered box with text
  Widget buildSectionCardBox(Map<String, dynamic> section) {
    String sectionId = section['_id'];
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6),
        color: const Color.fromARGB(255, 4, 37, 97),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            ListTile(
                contentPadding: const EdgeInsets.all(15),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Section ${section['sectionNumber']}",
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Anton',
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "${section['totalUnits']} Units",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 114, 186, 238),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 1.5, // Height of the line
                      width: double.infinity, // Width of the line
                      color: Colors.white, // Color of the line
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        "Title: ${section['title']}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anton',
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                subtitle: Center(
                  child: Text(
                    section['subTitle'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  MyTimeline(
                    sectionId: sectionId,
                  );
                  print("SEction is clicked $sectionId");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 4, 37, 97),
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Adjust the border radius
                  ),
                ),
                child: const Text('Start Learning'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
