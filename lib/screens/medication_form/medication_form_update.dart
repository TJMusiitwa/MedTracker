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
    var nameController = watch(medicationNameEntryController);
    var dosageController = watch(dosageEntryController);
    var frequencyValue = watch(frequencyProvider);
    var treatmentLengthController = watch(treatmentLengthEntryController);
    var reminder = watch(reminderSwitchProvider).state;
    var currUser = watch(firebaseAuthProvider).currentUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Medication'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Save medication'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                context
                    .read(firestoreService)
                    .updateMedication(
                        userId: currUser,
                        medication: Medication(
                            dosage: dosageController.text,
                            frequency: frequencyValue.state,
                            medicationName: nameController.text,
                            treatmentLength: treatmentLengthController.text,
                            reminder: reminder,
                            uploadTimeStamp: DateTime.now().toLocal()))
                    .whenComplete(() => Navigator.pop(context));
                //Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
