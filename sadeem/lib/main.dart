import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadeem/provider/theme_provider.dart';
import 'package:sadeem/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLightTheme = prefs.getBool('isLightTheme') ?? true;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'My App',
      theme: themeProvider.getThemeData (),
      home: LoginScreen(),
    );
  }
}

