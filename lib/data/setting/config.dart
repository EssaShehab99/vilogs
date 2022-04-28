import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart' as Model;

class Config {
  static Future<void> setVerification(bool verification) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isInVerification", verification);
  }

  static Future<bool> getVerification() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool("isInVerification") ?? false;
  }

  static Future<void> setUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("password", password);
  }

  static Future<Model.User> getUser() async {
    Model.User? user;
    final prefs = await SharedPreferences.getInstance();
    user = Model.User(
        email: await prefs.getString("email"),
        password: await prefs.getString("password"));
    return user;
  }
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("password");
  }
}
