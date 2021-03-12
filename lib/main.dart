import 'package:flutter/material.dart';
import 'package:med_tracker/login/login_screen.dart';
import 'package:med_tracker/medtrackerTheme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MedTracker',
        debugShowCheckedModeBanner: false,
        theme: medTrackerTheme,
        home: LoginScreen());
  }
}
