import 'package:flutter/material.dart';
import 'package:frontend/presentation/admin_dashboard/dialogue_alert/view_childUserDetailAlert.dart';

class BuildChildUserCardService {
  static dynamic onViewClick(
      BuildContext context, Map<String, dynamic> childProfileData) {
    return ViewChildUserDetailAlert.viewChildUserDetailAlert(
        context, childProfileData);
  }
}
