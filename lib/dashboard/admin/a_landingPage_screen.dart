import 'package:flutter/material.dart';
import 'package:frontend/dashboard/admin/a_legalContent_screen.dart';
import 'package:frontend/presentation/footer/admin_footer_screen.dart';
import 'package:frontend/dashboard/admin/a_home_screen.dart';
import 'package:frontend/dashboard/admin/a_legalExpert_screen.dart';
import 'package:frontend/dashboard/admin/a_organisation_screen.dart';
import 'package:frontend/presentation/header/header_screen.dart';

class AdminLandingScreen extends StatefulWidget {
  final bool selectLegalExpertScreen;
  final bool selectLegalContentScreen;

  const AdminLandingScreen({
    Key? key,
    this.selectLegalExpertScreen = false,
    this.selectLegalContentScreen = false,
  }) : super(key: key);

  @override
  _AdminLandingScreenState createState() => _AdminLandingScreenState();
}

class _AdminLandingScreenState extends State<AdminLandingScreen> {
  late int _currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    if (widget.selectLegalExpertScreen) {
      _currentIndex = 2;
    } else if (widget.selectLegalContentScreen) {
      _currentIndex = 1;
    } else {
      _currentIndex = 0; // AdminHomeScreen by default
    }
    pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    if (mounted) {
      pageController.dispose();
    }
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
        children: const [
          // Your different screens go here
          AdminHomeScreen(),
          LegalContentScreen(),
          LegalExpertRoleScreen(),
          OrganisationScreen(),
        ],
      ),
      bottomNavigationBar: AdminFooterScreen(
        currentTab: _currentIndex,
        pageController: pageController,
      ),
    );
  }
}
