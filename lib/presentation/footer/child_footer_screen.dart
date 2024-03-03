// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UserFooterScreen extends StatefulWidget {
  int currentTab;
  final PageController pageController;
  UserFooterScreen(
      {Key? key, required this.currentTab, required this.pageController})
      : super(key: key);
  @override
  _UserFooterScreenState createState() => _UserFooterScreenState();
}

class _UserFooterScreenState extends State<UserFooterScreen> {
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
            _buildNavItem(Icons.question_answer, Icons.question_answer_outlined, 'My Queries', 1),
            _buildNavItem(Icons.chat, Icons.chat_outlined, 'Ask Expert', 2),
            _buildNavItem(Icons.assistant, Icons.assistant_outlined, 'Assistance', 3),
          ],
        ),
      ),
    ],
  );
}


  /// Navigation tabs building and highlighting when clicked
  Widget _buildNavItem(IconData selectedIcon, IconData icon, String label, int index) {
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
              color: widget.currentTab == index ? const Color.fromARGB(255, 4, 37, 97) : Color.fromARGB(255, 8, 56, 146),// Highlight the icon color
            ),
            Text(
              label,
              style: TextStyle(
                color: widget.currentTab == index ? const Color.fromARGB(255, 4, 37, 97) : const Color.fromARGB(255, 8, 56, 146), // Highlight the label color
                fontSize: 15.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
