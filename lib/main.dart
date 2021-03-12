import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:med_tracker/medtrackerTheme.dart';
import 'package:med_tracker/screens/home/home_screen.dart';
import 'package:med_tracker/screens/login/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/services/service_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MedTracker',
        debugShowCheckedModeBanner: false,
        theme: medTrackerTheme,
        home: Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
            final _loadScreen = watch(authStateProvider);
            return _loadScreen.when(
                data: (userValue) {
                  if (userValue != null) {
                    return HomeScreen();
                  }
                  return LoginScreen();
                },
                loading: () =>
                    Scaffold(body: Center(child: CircularProgressIndicator())),
                error: (Object error, StackTrace stackTrace) {
                  print(error.toString());
                  return;
                });
          },
        ));
  }
}
