import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/presentation/confirmation_alert/error_confirmation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AddVideoService {
  final ImagePicker _picker = ImagePicker();
  Future<String?> addVideo(BuildContext context) async {
    String? videoUrl;
    final pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);  
    List<String> validExtensions = ['.mp4', '.mov', '.avi', '.mkv'];

    if (pickedVideo != null) {
      try {
        String fileExtension = pickedVideo.name.split('.').last.toLowerCase();
        if (validExtensions.contains('.$fileExtension')) {
          videoUrl = await uploadVideo(pickedVideo);
          if (videoUrl != null) {
            print('Video uploaded successfully: $videoUrl');
          } else {
            print("No upload");
          }
        } else {
          String error = 'Invalid file format';
          String errorMessage = 'Only .mp4, .mov, .avi and .mkv videos are allowed.';
          ErrorConfirmation.errorConfirmationAlert(context, error, errorMessage);
        }
      } catch (e) {
        print(e);
      }
    }
    return videoUrl;
  }

  Future<String?> uploadVideo(XFile videoFile) async {
    String? cloudUrl = dotenv.env['UPLOAD_VIDEO_URL'];
    final url = Uri.parse(cloudUrl!);

    final bytes = await videoFile.readAsBytes();
    final encodedVideo = base64Encode(bytes);
    try {
      final response = await http.post(
        url,
        body: {
          'upload_preset': dotenv.env['CLOUD_UPLOAD_PRESET'],
          'file': 'data:video/mp4;base64,$encodedVideo'
        },
        headers: {
          'Content-Type':
              'application/x-www-form-urlencoded',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final secureUrl = jsonResponse['secure_url'];
        int startIndex = secureUrl.indexOf('upload/') + 'upload/'.length;
        String extractedContent = secureUrl.substring(startIndex);
        return extractedContent;
      } else {
        print('Failed to upload video: ${response.statusCode}');
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }
}
