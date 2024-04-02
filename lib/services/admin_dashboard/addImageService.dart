import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddImageService {
  final ImagePicker _picker = ImagePicker();

  Future<String?> addImage(BuildContext context) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    String? imageUrl;
    List<String> validExtensions = ['.jpg', '.jpeg', '.png'];

    if (pickedImage != null) {
      try {
        String fileExtension = pickedImage.path.split('.').last.toLowerCase();
        if (validExtensions.contains('.$fileExtension')) {
          imageUrl = await uploadImage(pickedImage);
          if (imageUrl != null) {
            print('Image uploaded successfully: $imageUrl');
          } else {
            print("No upload");
          }
        } else {
          String error = 'Invalid file format';
          String errorMessage = 'Only .jpg, .jpeg, and .png images are allowed.';
          ErrorConfirmation.errorConfirmationAlert(context, error, errorMessage);
          throw Exception(
              'Invalid file format. Only .jpg, .jpeg, and .png images are allowed.');
        }
      } catch (e) {
        print(e);
      }
    }
    return imageUrl;
  }

  Future<String?> uploadImage(XFile imageFile) async {
    await dotenv.load(fileName: '.env');
    String? cloudUrl = dotenv.env['UPLOAD_IMAGE_URL'];
    final url = Uri.parse(cloudUrl!);

    final bytes = await imageFile.readAsBytes();
    final encodedImage = base64Encode(bytes);
    try {
      final response = await http.post(
        url,
        body: {
          'upload_preset': dotenv.env['CLOUD_UPLOAD_PRESET'],
          'file': 'data:image/jpeg;base64,$encodedImage'
        },
        headers: {
          'Content-Type':
              'application/x-www-form-urlencoded', // Change content type to application/x-www-form-urlencoded
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final secureUrl = jsonResponse['secure_url'];
        int startIndex = secureUrl.indexOf('upload/') + 'upload/'.length;
        String extractedContent = secureUrl.substring(startIndex);
        return extractedContent;
      } else {
        print('Failed to upload image: ${response.statusCode}');
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }
}
