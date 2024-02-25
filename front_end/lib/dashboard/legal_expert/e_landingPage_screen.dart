import 'package:flutter/material.dart';
import 'package:frontend/dashboard/legal_expert/e_legalExpertQueries.dart';
import 'package:frontend/presentation/footer/expert_footer_screen.dart';
import 'package:frontend/presentation/header/header_screen.dart';
import 'package:frontend/dashboard/legal_expert/e_HomePage_screen.dart';

class LegalExpertLandingScreen extends StatefulWidget {
  const LegalExpertLandingScreen({super.key});

  @override
  _LegalExpertLandingScreenState createState() =>
      _LegalExpertLandingScreenState();
}

class _LegalExpertLandingScreenState extends State<LegalExpertLandingScreen> {
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
    return Scaffold(
        appBar: const HeaderScreen(),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            LegalHomeScreen(), // Add your LegalHomeScreen here
            LegalExpertQueriesScreen(),
          ],
        ),
        bottomNavigationBar: LegalExpertFooterScreen(
          currentTab: _currentIndex,
          pageController: pageController,
        ));
  }
}
