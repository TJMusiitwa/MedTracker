import 'package:flutter/material.dart';
import 'package:med_tracker/medication_form/medication_form_screen.dart';
import 'package:med_tracker/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  static String greeting = DateTime.now().hour >= 6 && DateTime.now().hour < 12
      ? 'Good Morning,\nUser 10234'
      : DateTime.now().hour >= 12 && DateTime.now().hour <= 18
          ? 'Good Afternoon\nUser 10234'
          : 'Good Evening\nUser 10234';

  @override
  Widget build(BuildContext context) {
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
                  Text(greeting,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
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
