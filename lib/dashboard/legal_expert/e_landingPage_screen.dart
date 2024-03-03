// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HeaderScreen(),
        body: LegalExpertHomeScreen(),
        bottomNavigationBar: LegalExpertFooterScreen());
  }
}
