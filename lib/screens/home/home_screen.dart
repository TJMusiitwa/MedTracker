import 'package:flutter/material.dart';
import 'package:med_tracker/screens/medication_form/medication_form_screen.dart';
import 'package:med_tracker/screens/profile/profile_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/services/service_providers.dart';

class HomeScreen extends ConsumerWidget {
  //final String userID;
  // static String greeting = DateTime.now().hour >= 6 && DateTime.now().hour < 12
  //     ? 'Good Morning,\nUser$userID'
  //     : DateTime.now().hour >= 12 && DateTime.now().hour <= 18
  //         ? 'Good Afternoon\nUser 10234'
  //         : 'Good Evening\nUser 10234';

  String greetingFunc(String userID) {
    DateTime.now().hour >= 6 && DateTime.now().hour < 12
        ? 'Good Morning,\nUser $userID'
        : DateTime.now().hour >= 12 && DateTime.now().hour <= 18
            ? 'Good Afternoon\nUser $userID'
            : 'Good Evening\nUser $userID';
    return userID;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var currUser = watch(firebaseAuthProvider).currentUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(greetingFunc(currUser.uid),
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Hero(
                    tag: 'UserID',
                    transitionOnUserGestures: true,
                    child: GestureDetector(
                      child: CircleAvatar(
                        child: Icon(Icons.person_outline),
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProfileScreen())),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MedicationFormScreen(),
                fullscreenDialog: true)),
        icon: Icon(Icons.add),
        label: Text('Add medication'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
