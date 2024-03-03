// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/services/common/roleBasedScreen_Service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () async {
      RoleBasedScreenService.roleBasedScreenRedirection(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double logoSize = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 37, 97),
      body: Center(
        child: SizedBox(
          width: logoSize,
          height: logoSize,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
