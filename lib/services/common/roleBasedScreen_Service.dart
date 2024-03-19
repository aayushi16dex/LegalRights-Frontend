// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/foundation.dart';
import 'package:frontend/api_call/profileData_api/profileData_apiCall.dart';
import 'package:frontend/core/role.dart';
import 'package:frontend/dashboard/legal_expert/e_landingPage_screen.dart';
import 'package:frontend/dashboard/child/c_landingPage_screen.dart';

import 'package:flutter/material.dart';
import 'package:frontend/core/TokenManager.dart';
import 'package:frontend/dashboard/admin/a_landingPage_screen.dart';

import '../../presentation/signin/signin_screen.dart';

class RoleBasedScreenService {
  static Future<void> roleBasedScreenRedirection(BuildContext context) async {
    final String authToken = await TokenManager.getAuthToken();
    if (authToken != '') {
      String role = await ProfileHeaderDataApiCal.profileDataApi(context);
      if (role == roleChild) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserLandingScreen()));
      } else if (role == roleLegalExpert) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LegalExpertLandingScreen()));
      } else if (role == roleAdmin) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminLandingScreen()));
      } else {
        if (kDebugMode) {
          print("No role found");
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }
}
