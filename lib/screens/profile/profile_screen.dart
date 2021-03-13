import 'package:flutter/material.dart';
import 'package:med_tracker/screens/login/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/services/service_providers.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    Hero(
                      tag: 'UserID',
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person_outline,
                          size: 30,
                        ),
                        backgroundColor: Theme.of(context).accentColor,
                        radius: 50,
                      ),
                    ),
                    Consumer(
                      builder: (context, watch, child) {
                        var currUser =
                            watch(firebaseAuthProvider).currentUser.uid;
                        return Text(
                          currUser,
                          style: Theme.of(context).textTheme.headline6,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.transparent, height: 25),
              ListTile(
                leading: Icon(
                  Icons.outbond,
                  color: Theme.of(context).accentColor,
                ),
                title: Text('Export My Data'),
                onTap: () => null,
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).accentColor,
                ),
                title: Text('About MedTracker'),
                onTap: () => showLicensePage(context: context),
              ),
              Expanded(child: Container()),
              OutlinedButton(
                child: Text('Sign Out'),
                style: OutlinedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: BorderSide(color: Colors.grey, width: 2),
                  padding: EdgeInsets.all(15),
                  textStyle: Theme.of(context).textTheme.button.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                onPressed: () {
                  context
                      .read(authServiceProvider)
                      .anonymSignOut()
                      .whenComplete(() {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      ModalRoute.withName('/'),
                    );
                  });
                },
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Account?'),
                          content: Text(
                            'Deleting your account will remove all data associated with this account. \nThis action is irreversiable',
                            softWrap: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('No'),
                              style: TextButton.styleFrom(primary: Colors.blue),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen()),
                                ModalRoute.withName('/'),
                              ),
                              child: Text('Yes'),
                              style: TextButton.styleFrom(
                                  primary: Colors.redAccent),
                            )
                          ],
                        );
                      }),
                  child: Text(
                    'Delete Account',
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    textStyle: Theme.of(context).textTheme.button.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
