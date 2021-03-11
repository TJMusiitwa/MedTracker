import 'package:flutter/material.dart';
import 'package:med_tracker/login/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MedTracker',
        theme: ThemeData(
          primaryColor: Colors.white,
          primaryColorBrightness: Brightness.light,
          accentColor: Color.fromRGBO(249, 97, 107, 1),
          accentColorBrightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen());
  }
}
