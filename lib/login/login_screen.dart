import 'package:flutter/material.dart';
import 'package:med_tracker/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Text(
                'MedTracker',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.bold),
              )),
              Container(
                child: Image.asset('assets/login.png'),
                height: MediaQuery.of(context).size.height * 0.6,
                alignment: Alignment.center,
              ),
              Expanded(
                child: Container(),
              ),
              ElevatedButton(
                child: Text('LOGIN'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                onPressed: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen())),
              )
            ],
          ),
        ),
      ),
    );
  }
}
