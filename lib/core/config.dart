import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AppConfig {
  static final List<String> baseUrls = [
    'http://localhost:5000',
    'http://192.168.0.127:5000',
    'http://192.168.1.4:5000'
    'http://192.168.1.10:5000',
    'http://192.168.54.68:5000'
  ];

  static String? _baseUrl;
  static String? get baseUrl => _baseUrl;
  static bool get isBaseUrlInitialized => _baseUrl != null;

  static Future<void> initialize() async {
    for (String url in baseUrls) {
      //print('Checking URL: $url');
      if (await checkUrlAvailability(url)) {
        _baseUrl = url;
        if (kDebugMode) {
          print('Base URL set to: $_baseUrl');
        }
        return;
      }
    }
    if (kDebugMode) {
      print('No available base URL');
    }
  }

  static Future<bool> checkUrlAvailability(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static String _createUrl(String path) {
    if (_baseUrl == null) {
      throw Exception("Base URL is not initialized");
    }
    return '$_baseUrl$path';
  }

  // Signin url
  static String get signInUrl => _createUrl('/user/login');

  static String get fetchexpertListByUser => _createUrl('/expert/fetchList');
  static String get postquery => _createUrl('/askExpert/raiseQuery');
  static String get fetchquery => _createUrl('/askExpert/fetchQueries');
  static String get changeExpertAccountInfo => _createUrl('/admin/editExpert');

  // Legal Expert Routes
  static String get fetchQueriesCount => _createUrl('/expert/fetchCount');
  static String get fetchUnansweredQueries =>
      _createUrl('/expert/fetchUserQueries');
  static String get fetchAnsweredQueries =>
      _createUrl('/expert/fetchAnsweredUserQueries');
  static String get answerQuery => _createUrl('/expert/answerQuery');
  static String get fetchExpertById => _createUrl('/expert/fetch');

  /* Admin Dashboard */

  static String get addLanguage => _createUrl('/admin/addLanguage');
  static String get addExpertise => _createUrl('/admin/addExpertise');
  static String get addProfession => _createUrl('/admin/addProfession');
  static String get changeExpertStatus => _createUrl('/admin/changeStatus');
  static String get legalExpertRegisterUrl => _createUrl('/admin/addExpert');
  static String get addSection => _createUrl('/admin/section');
  static String get deleteSection => _createUrl('/admin/deleteSection');

  // Organisation Tab
  static String get deleteOrganisation =>
      _createUrl('/admin/deleteOrganisation');
  static String get addorEditOrganisation => _createUrl('/admin/organisation');

  //Fetch
  static String get fetchCount => _createUrl('/admin/fetchHomePageCount');
  static String get fetchProfession => _createUrl('/admin/fetchProfession');
  static String get fetchLanguage => _createUrl('/admin/fetchLanguage');
  static String get fetchState => _createUrl('/admin/fetchStates');
  static String get fetchExpertise => _createUrl('/admin/fetchExpertise');
  static String get fetchExpertsListByAdmin =>
      _createUrl('/admin/fetchExperts');
  static String get fetchAllUser => _createUrl('/admin/fetchAllUser');
  static String get fetchUserById => _createUrl('/admin/fetchUser');

  // Organisaiton routes
  static String get fetchOrganisationList =>
      _createUrl('/organisation/fetchList');
  static String get fetchOrganisationById => _createUrl('/organisation/fetch');

  // Legal content
  static String get fetchSections => _createUrl('/content/fetchSections');
  static String get fetchSectionContentById =>
      _createUrl('/content/fetchSection');
  static String get addSubSection => _createUrl('/admin/subSection');

  // User profile 
    static String get forgotPasswordUrl =>
      _createUrl('/user/resetPasswordRequest');
  static String get changePassword => _createUrl('/user/changePassword');
  static String get changeAccountInfo => _createUrl('/user/edit');
    static String get userUrl => _createUrl('/user');
  static String get fetchDisplayPicture => _createUrl('/user');
  static String get userSignUpUrl => _createUrl('/user/register');
  static String get profileUrl => _createUrl('/user/profile');
  static String get deleteProfile => _createUrl('/user/deleteAccount');
  static String get uploadProfilePicture => _createUrl('/user/uploadProfilePicture');

}
