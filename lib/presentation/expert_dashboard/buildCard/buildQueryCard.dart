import 'package:flutter/material.dart';
import 'package:frontend/services/expert_dashboard/buildQueryCard_service.dart';

class BuildQueryCard {
  static Widget buildCard(String title, BuildContext context, int index) {
    BuildQueryCardService buildQueryCardService = BuildQueryCardService();
    final Color color = Color.fromARGB(255, 4, 37, 97);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        // Wrap Card in a Container
        width: double.infinity, // Set width to take the full screen width
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(10),
          color: color,
          child: InkWell(
            onTap: () {
              buildQueryCardService.getQueryScreenDetail(context, index);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // Text color
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
