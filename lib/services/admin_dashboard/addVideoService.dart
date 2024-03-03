// ignore_for_file: unused_local_variable, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddVideoService {
  static Future<void> pickVideo(BuildContext context) async {
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
        String filePath = kIsWeb
            ? 'web_file'
            : result.files.single.path ?? 'unknown_file_path';

        List<int> bytes = result.files.single.bytes ?? [];

        print('Selected video file path: $filePath');
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }
}
