import 'package:flutter/material.dart';

class BuildSectionCardBox {
  // Function to build a round-cornered box with text
  Container buildSectionCardBox(Map<String, dynamic> section) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      width: 350.0,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 4, 37, 97),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            "Section ${section['sectionNumber']} : ${section['title']}",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Anton',
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 5.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${section['totalUnits']} Units",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 114, 186, 238),
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 25),
                ),
                // Dynamic progress bar
                const SizedBox(
                  height: 5.0,
                  // Adjust the height as needed
                  child: LinearProgressIndicator(
                    value: 0.4, // Set the completion percentage here
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 114, 186, 238)),
                  ),
                ),
                SizedBox(height: 5.0),
                // Subtitle text
                Text(
                  section['subTitle'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  section['summary'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ), //fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Button
          Container(
            margin: const EdgeInsets.all(20.0), // Margin all sides
            width: double.infinity, // Take the full width of the box
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 4, 37, 97),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                ),
              ),
              child: const Text('Continue',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
