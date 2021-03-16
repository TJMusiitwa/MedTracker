import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/services/service_providers.dart';

class HistoryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var currUser = watch(firebaseAuthProvider).currentUser;
    final historyList = watch(firestoreProvider)
        .collection('medications')
        .doc(currUser.uid)
        .collection('userMedications')
        .where('medicationExpiry',
            isLessThan: DateTime.now().toLocal().toString().split(' ')[0])
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: historyList,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    children: [
                      Image.asset(
                        'assets/no_data.png',
                        height: 500,
                        width: 300,
                        color: Colors.grey.shade400,
                        colorBlendMode: BlendMode.lighten,
                      ),
                      Text(
                        'Your past medications will show up here',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 20),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((doc) {
                        var hist = doc.data();
                        return Card(
                          child: ListTile(
                            title: Text(hist['medicationName']),
                            subtitle: Text(
                                'Prescription: ${hist['frequency']}${hist['dosage']}\nTreatment Duration: ${hist['treatmentLength']} days'),
                            isThreeLine: true,
                          ),
                        );
                      }).toList()),
                );
        },
      ),
    );
  }
}
