// ignore_for_file: avoid_print, file_names

import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class TokenManager {
  static Future<void> storeAuthToken(String token) async {
    const isWeb = kIsWeb;

    if (isWeb) {
      try {
        final int expirationTime = DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch;
        final tokenCookie =
            'token=$token; expires=${DateTime.fromMillisecondsSinceEpoch(expirationTime).toUtc().toIso8601String()}; path=/';
        html.document.cookie = tokenCookie;
        //print('Web: Token stored successfully');
      } catch (e) {
        print('Web: Error storing token: $e');
      }
    } else {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        //print('Mobile: Token and userId stored successfully');
      } catch (e) {
        print('Mobile: Error storing token: $e');
      }
    }
  }

  static Future<String> getAuthToken() async {
    const isWeb = identical(0, 0.0);
    if (isWeb) {
      return _getCookieValue('token');
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token') ?? '';
    }
  }

  static String _getCookieValue(String name) {
    final cookies = html.document.cookie;
    if (cookies == null || cookies.isEmpty) {
      return '';
    }
    final cookie = cookies.split(';').firstWhere(
          (cookie) => cookie.trim().startsWith('$name='),
          orElse: () => '',
        );

    if (cookie.isNotEmpty) {
      return cookie.split('=')[1];
    } else {
      return '';
    }
  }

  static Future<void> clearTokens() async {
    const isWeb = kIsWeb;

    if (isWeb) {
      try {
        html.document.cookie = 'token=; path=/';
      } catch (e) {
        print('Web: Error clearing tokens: $e');
      }
    } else {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
      } catch (e) {
        print('Mobile: Error clearing tokens: $e');
      }
    }
  }
}
