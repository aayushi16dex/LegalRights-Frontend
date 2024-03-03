import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddVideoService {
  static Future<String?> pickVideo(BuildContext context) async {
    try {
      FilePickerResult? result;
      if (kIsWeb) {
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp4', 'mov', 'avi', 'mkv'],
          allowMultiple: false,
        );
      } else {
        result = await FilePicker.platform.pickFiles(
          type: FileType.video,
          allowMultiple: false,
        );
      }

      if (result != null && result.files.isNotEmpty) {
        String filePath;
        if (kIsWeb) {
          List<int> bytes = result.files.single.bytes ?? [];
          filePath = base64Encode(bytes); // Encode the content
        } else {
          // On other platforms, use the file path
          filePath = result.files.single.path ?? 'unknown_file_path';
          print('Selected video file path: $filePath');
        }

        return filePath; // Return the selected video path or content
      }

      return null; // Return null if no video is selected
    } catch (e) {
      print('Error picking video: $e');
      return null; // Return null in case of an error
    }
  }
}
