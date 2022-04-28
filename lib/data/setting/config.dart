
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static Future<void> setVerification(bool verification) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isInVerification", verification);
  }

  static Future<bool> getVerification() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getBool("isInVerification")??false;
  }

  static Future<void> setUser(bool verification) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isInVerification", verification);
  }
}
