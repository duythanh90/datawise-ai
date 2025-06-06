import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  // Keys
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';
  static const String userPhoneKey = 'user_phone';
  static const String userIdKey = 'user_id';
  static const String userTokenKey = 'user_token';
  static const String userProfilePicKey = 'user_profile_pic';
  static const String userLanguageKey = 'user_language';

  // User name
  static Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  // User email
  static Future<void> setUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userEmailKey, email);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  // User phone
  static Future<void> setUserPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPhoneKey, phone);
  }

  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoneKey);
  }

  // User ID
  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // User token
  static Future<void> setUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userTokenKey, token);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenKey);
  }

  // User profile picture
  static Future<void> setUserProfilePic(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userProfilePicKey, url);
  }

  static Future<String?> getUserProfilePic() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  // User language
  static Future<void> setUserLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userLanguageKey, lang);
  }

  static Future<String?> getUserLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userLanguageKey);
  }

  // Clear all stored user data
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userNameKey);
    await prefs.remove(userEmailKey);
    await prefs.remove(userPhoneKey);
    await prefs.remove(userIdKey);
    await prefs.remove(userTokenKey);
    await prefs.remove(userProfilePicKey);
    await prefs.remove(userLanguageKey);
  }
}
