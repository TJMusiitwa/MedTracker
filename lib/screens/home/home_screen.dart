import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_tracker/screens/history/history_screen.dart';
import 'package:med_tracker/screens/medication_form/medication_form_entry_screen.dart';
import 'package:med_tracker/screens/medication_form/medication_form_update_screen.dart';
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
    if (DateTime.now().hour >= 6 && DateTime.now().hour < 12) {
      return 'Good Morning,\n$userID';
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour <= 18) {
      return 'Good Afternoon\n$userID';
    } else {
      return 'Good Evening\n$userID';
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var currUser = watch(firebaseAuthProvider).currentUser;
    // final medList =
    //     watch(firestoreService).readMedications(userId: currUser.uid);
    //final medListState = watch(firestoreControllerProvider.state);

    final medicationList = watch(firestoreProvider)
        .collection('medications')
        .doc(currUser.uid)
        .collection('userMedications')
        .orderBy('uploadTimeStamp', descending: true)
        .snapshots();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(greetingFunc(currUser.uid),
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontWeight: FontWeight.bold)),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.history,
                      size: 30,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HistoryScreen(),
                      ),
                    ),
                  ),
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
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: medicationList,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    return snapshot.data.docs.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/no_data.png',
                                  height: 500,
                                  width: 500,
                                  color: Colors.grey.shade400,
                                  colorBlendMode: BlendMode.lighten,
                                ),
                                Text(
                                  'No medications available',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(fontSize: 20),
                                )
                              ],
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: snapshot.data.docs.map((data) {
                              var med = data.data();
                              return Dismissible(
                                key: Key(data.id),
                                background: Container(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  color: Colors.red,
                                ),
                                onDismissed: (del) {
                                  context
                                      .read(firestoreService)
                                      .deleteMedication(
                                          userId: currUser.uid,
                                          medicationId: data.id);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    title: Text(med['medicationName'] ?? ''),
                                    subtitle: Text(
                                        'Prescription: ${med['frequency']}${med['dosage']}\nTreatment Duration: ${med['treatmentLength']} days'),
                                    isThreeLine: true,
                                    trailing: med['reminder'] == true
                                        ? Icon(
                                            Icons.notifications_active,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.notifications_off,
                                            color: Colors.red,
                                          ),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                MedicationUpdateForm(
                                                  docId: data.id,
                                                ),
                                            fullscreenDialog: true)),
                                  ),
                                ),
                              );
                            }).toList());
                  },
                ),
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
