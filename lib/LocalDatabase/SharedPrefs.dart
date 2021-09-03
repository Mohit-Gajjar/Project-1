import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceAdminLoggedInKey = "ADMINISLOGGEDIN";
  static String sharedPreferenceStudentLoggedInKey = "STUDENTISLOGGEDIN";
  static String sharedPreferenceTeacherLoggedInKey = "TEACHERISLOGGEDIN";

  static String sharedPreferenceAdminNameKey = "ADMINNAMEKEY";
  static String sharedPreferenceStudentNameKey = "STUDENTNAMEKEY";
  static String sharedPreferenceTeacherNameKey = "TEACHERNAMEKEY";

  static String sharedPreferenceAdminEmailKey = "ADMINEMAILKEY";
  static String sharedPreferenceStudentEmailKey = "STUDENTEMAILKEY";
  static String sharedPreferenceTeacherEmailKey = "TEACHEREMAILKEY";

  /// saving data to sharedpreference
  static Future<bool> saveAdminLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceAdminEmailKey, isUserLoggedIn);
  }

  static Future<bool> saveStudentLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceStudentLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveTeacherLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceTeacherLoggedInKey, isUserLoggedIn);
  }

// ================================================================================================================
  static Future<bool> saveAdminNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceAdminNameKey, userName);
  }

  static Future<bool> saveStudentNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceStudentNameKey, userName);
  }

  static Future<bool> saveTeacherNameSharedPreference(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceTeacherNameKey, userName);
  }

// ================================================================================================================
  static Future<bool> saveAdminEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceAdminEmailKey, userEmail);
  }
   static Future<bool> saveStudentEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceStudentEmailKey, userEmail);
  }
   static Future<bool> saveTeacherEmailSharedPreference(String userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceTeacherEmailKey, userEmail);
  }
// ================================================================================================================

  /// fetching data from sharedpreference
  static Future<bool?> getAdminLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceAdminLoggedInKey);
  }
   static Future<bool?> getStudentLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceStudentLoggedInKey);
  }
   static Future<bool?> getTeacherLoggedInSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(sharedPreferenceTeacherLoggedInKey);
  }
// ================================================================================================================

  static Future<String?> getAdminNameSharedPreference(doc) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceAdminNameKey);
  }
    static Future<String?> getStudentNameSharedPreference(doc) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceStudentNameKey);
  }
    static Future<String?> getTeacherNameSharedPreference(doc) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceTeacherNameKey);
  }
  
// ================================================================================================================

  static Future<String?> getAdminEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceAdminEmailKey);
  }
   static Future<String?> getStudentEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceStudentEmailKey);
  }
   static Future<String?> getTeacherEmailSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceTeacherEmailKey);
  }
// ================================================================================================================

}
