import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/models/medication_model.dart';
import 'package:med_tracker/screens/medication_form/medication_form_providers.dart';
import 'package:med_tracker/services/service_providers.dart';

class MedicationUpdateForm extends ConsumerWidget {
  final String docId;

  MedicationUpdateForm({this.docId});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var currUser = watch(firebaseAuthProvider).currentUser.uid;
    var getMedication = watch(firestoreService)
        .readSingleMedication(userId: currUser, medicationId: docId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Medication'),
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getMedication,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var details = snapshot.data.data();
          var nameController = context
              .read(medicationNameUpdateController(details['medicationName']));
          var dosageController =
              context.read(dosageUpdateController(details['dosage']));
          var frequencyValue =
              context.read(frequencyUpdateProvider(details['frequency'])).state;
          var treatmentLengthController = context.read(
              treatmentLengthUpdateController(details['treatmentLength']));
          var reminder = context
              .read(reminderSwitchUpdateProvider(details['reminder']))
              .state;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return snapshot.hasData == null
              ? Text('No data to show')
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Medication Name',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(labelText: 'Frequency'),
                          iconEnabledColor: Theme.of(context).accentColor,
                          value: frequencyValue,
                          items: [
                            DropdownMenuItem(
                                child: Text('Once a day'), value: '1x'),
                            DropdownMenuItem(
                                child: Text('Twice a day'), value: '2x'),
                            DropdownMenuItem(
                                child: Text('Thrice a day'), value: '3x'),
                          ],
                          onChanged: (frequencySelected) =>
                              frequencyValue = frequencySelected),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: dosageController,
                        decoration: InputDecoration(
                            labelText: 'Dosage', hintText: '2 pills'),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: treatmentLengthController,
                        decoration: InputDecoration(
                            labelText: 'Treatment length', suffixText: 'days'),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SwitchListTile.adaptive(
                        title: Text('Reminder'),
                        value: reminder,
                        onChanged: (reminderSet) => reminder = reminderSet,
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.upload_file),
                        label: Text('Update medication'),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        onPressed: () {
                          context
                              .read(firestoreService)
                              .updateMedication(
                                  userId: currUser,
                                  medicationId: docId,
                                  medication: Medication(
                                      dosage: dosageController.text,
                                      frequency: frequencyValue,
                                      medicationName: nameController.text,
                                      treatmentLength:
                                          treatmentLengthController.text,
                                      reminder: reminder,
                                      medicationExpiry: DateTime.now()
                                          .add(Duration(
                                              days: int.tryParse(
                                                  treatmentLengthController
                                                      .text)))
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0],
                                      uploadTimeStamp:
                                          details['uploadTimeStamp']))
                              .whenComplete(() => Navigator.pop(context));
                          //Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
