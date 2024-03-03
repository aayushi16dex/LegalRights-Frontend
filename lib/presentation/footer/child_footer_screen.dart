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
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.chat, 'My Queries', 1),
          _buildNavItem(Icons.chat, 'Ask Expert', 2),
          _buildNavItem(Icons.assistant, 'Assistance', 3),
        ],
      ),
    );
  }

  /// Navigation tabs building and highlighting when clicked
  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.currentTab = index;
          widget.pageController.jumpToPage(index);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: widget.currentTab == index
              ? const Color.fromARGB(255, 4, 37, 97)
              : Colors.transparent, // Highlight the selected tab
          //borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: widget.currentTab == index
                  ? Colors.white
                  : const Color.fromARGB(
                      255, 4, 37, 97), // Highlight the icon color
            ),
            Text(
              label,
              style: TextStyle(
                color: widget.currentTab == index
                    ? Colors.white
                    : const Color.fromARGB(
                        255, 4, 37, 97), // Highlight the label color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
