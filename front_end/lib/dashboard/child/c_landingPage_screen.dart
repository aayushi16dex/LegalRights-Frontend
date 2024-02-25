import 'package:flutter/material.dart';
import 'package:frontend/presentation/footer/child_footer_screen.dart';
import 'package:frontend/dashboard/child/c_myQuery_screen.dart';
import 'package:frontend/presentation/header/header_screen.dart';
import 'package:frontend/dashboard/child/c_askExpert_screen.dart';
import 'package:frontend/dashboard/child/c_seek_assistance_screen.dart';
import 'package:frontend/dashboard/child/c_homePage_screen.dart';

class UserLandingScreen extends StatefulWidget {
  const UserLandingScreen({super.key});

  @override
  _UserLandingScreenState createState() => _UserLandingScreenState();
}

class _UserLandingScreenState extends State<UserLandingScreen> {
  int _currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: const HeaderScreen(),
            body: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: const [
                // Your different screens go here
                UserHomeScreen(),
                MyQueryScreen(),
                AskExpertScreen(),
                SeekAssistanceScreen(),
              ],
            ),
            bottomNavigationBar: UserFooterScreen(
              currentTab: _currentIndex,
              pageController: pageController,
            )));
  }

  Future<bool> _onBackPressed() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout?'),
            content: const Text('Do you really want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  // Perform logout or any other cleanup operations here
                  // For now, we just exit the app
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
