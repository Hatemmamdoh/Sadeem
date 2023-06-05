import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  final String themeKey = 'isLightTheme';

  ThemeProvider({required this.isLightTheme});

  ThemeData getThemeData (){
    return isLightTheme ? lightTheme : darkTheme ;
  }

  void setThemeData(bool val) async {
    if (val) {
      isLightTheme = true;
    } else {
      isLightTheme = false;
    }
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isLightTheme);
  }
  Future<void> fetchThemeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLightTheme = prefs.getBool(themeKey) ?? true;
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: Color(0xFF000000),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black54,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);