import 'package:flutter/material.dart';
import 'package:libraryapp/podo/user.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStateProvider {
  static User currentUser = User();

  static Future<void> setCurrentUser(dynamic user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser = user.feed.single;
    prefs.setString("currentUserEmail", jsonEncode(currentUser.toJson()));
  }

  static Future<User> getLoginState() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser = prefs.containsKey("currentUserEmail")
        ? User.fromJson(jsonDecode(prefs.getString("currentUserEmail")))
        : null;
    return currentUser;
  }

  static Future<void> removeCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("currentUserEmail");
  }
}
