import 'package:flutter/material.dart';

class HomePageCard {
  static Widget buildCard(String title, int count) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: const Color.fromARGB(255, 4, 37, 97), // Dark blue background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // White text
            ),
            const SizedBox(height: 10),
            Text(
              'Count: $count',
              style: const TextStyle(
                  fontSize: 16, color: Colors.white), // White text
            ),
          ],
        ),
      ),
    );
  }
}
