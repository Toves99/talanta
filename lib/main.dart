import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanta_new/screens/recommendations/career_details.dart';
import 'package:talanta_new/screens/user/sign_in.dart';
import 'package:talanta_new/screens/user/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(
    MaterialApp(home: SplashScreen()), // use MaterialApp
  );
}

