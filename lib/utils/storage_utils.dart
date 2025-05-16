import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';
  static const String userPhoneKey = 'user_phone';
  static const String userIdKey = 'user_id';
  static const String userTokenKey = 'user_token';
  static const String userProfilePicKey = 'user_profile_pic';
  static const String userLanguageKey = 'user_language';

  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userEmailKey, email);
  }

  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<void> saveUserPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPhoneKey, phone);
  }

  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoneKey);
  }

  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  static Future<void> saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userTokenKey, token);
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenKey);
  }

  static Future<void> saveUserProfilePic(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userProfilePicKey, url);
  }

  static Future<String?> getUserProfilePic() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  static Future<void> saveUserLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userLanguageKey, lang);
  }

  static Future<String?> getUserLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userLanguageKey);
  }

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
