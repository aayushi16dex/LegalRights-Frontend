// ignore: file_names
import 'dart:convert';

import 'package:frontend/api_call/userChild_api/uploadProfilePicApi.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:frontend/presentation/confirmation_alert/upload_image_confirmation.dart';
import 'package:frontend/services/admin_dashboard/addImageService.dart';

class UpdateDisplayImage {
  static Future<String> updateDisplayPicture(context) async {
    AddImageService addImageService = AddImageService();
    String? imageUrl = await addImageService.addImage(context);
    if (imageUrl != null) {
      UploadProfilePicApi uploadProfilePicApi = UploadProfilePicApi();
      var response =
          await uploadProfilePicApi.uploadProfilePic(context, imageUrl);

      if (response.statusCode == 200) {
        UpdateImageConfirmationAlert.showImageUpdateConfirmationDialog(
            context, "Profile picture");
        Map<String, dynamic> responseData = json.decode(response.body);
        String displayPicture = responseData['displayPicture'];
        return displayPicture;
      } else {
        String errorMessage = 'Cannot upload display picture';
        String error = 'Try again after sometime';
        ErrorConfirmation.errorConfirmationAlert(context, errorMessage, error);
        return "";
      }
    }
    return "";
  }
}
