// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AdminFooterScreen extends StatefulWidget {
  int currentTab;
  final PageController pageController;
  AdminFooterScreen(
      {Key? key, required this.currentTab, required this.pageController})
      : super(key: key);
  @override
  _AdminFooterScreenState createState() => _AdminFooterScreenState();
}

class _AdminFooterScreenState extends State<AdminFooterScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 3.0, // Height of the horizontal bar
            color: Colors.grey, // Color of the horizontal bar
          ),
        ),
        Container(
          height: 60.0,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, Icons.home_outlined, 'Home', 0),
              _buildNavItem(
                  Icons.school, Icons.school_outlined, 'Legal Content', 1),
              _buildNavItem(
                  Icons.person_4, Icons.person_4_outlined, 'Legal Expert', 2),
              _buildNavItem(
                  Icons.house, Icons.house_outlined, 'Organisation', 3),
            ],
          ),
        ),
      ],
    );
  }

  /// Navigation tabs building and highlighting when clicked
  Widget _buildNavItem(
      IconData selectedIcon, IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.currentTab = index;
          widget.pageController.jumpToPage(index);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.currentTab == index ? selectedIcon : icon,
              size: 28,
              // Highlight the icon color
              color: widget.currentTab == index
                  ? const Color.fromARGB(255, 4, 37, 97)
                  : const Color.fromARGB(
                      255, 8, 56, 146), // Highlight the icon color
            ),
            Text(
              label,
              style: TextStyle(
                  color: widget.currentTab == index
                      ? const Color.fromARGB(255, 4, 37, 97)
                      : const Color.fromARGB(
                          255, 8, 56, 146), // Highlight the label color
                  fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }
}
