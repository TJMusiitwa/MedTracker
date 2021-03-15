import 'package:flutter/material.dart';
import 'package:med_tracker/screens/login/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/services/service_providers.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var currUser = watch(firebaseAuthProvider).currentUser.uid;
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 25),
                      child: Text(
                        currUser,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.outbond,
                  color: Theme.of(context).accentColor,
                ),
                title: Text('Export My Data'),
                onTap: () => context
                    .read(firestoreProvider)
                    .collection('medications')
                    .doc(currUser)
                    .collection('userMedications')
                    .get()
                    .then((snapshot) => snapshot.docs.forEach((doc) {
                          // var encoder = JsonEncoder.withIndent('  ');
                          // var prettyprint = encoder.convert(doc.data());
                          // debugPrint(prettyprint);
                          print(doc.data());
                        })),
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
            ],
          ),
        ),
      ),
    );
  }
}
