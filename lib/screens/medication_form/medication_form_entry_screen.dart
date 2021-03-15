import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/models/medication_model.dart';
import 'package:med_tracker/screens/medication_form/medication_form_providers.dart';
import 'package:med_tracker/services/service_providers.dart';

class MedicationFormScreen extends ConsumerWidget {
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
        title: Text('Add medication'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Medication Name',
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Frequency'),
                iconEnabledColor: Theme.of(context).accentColor,
                items: [
                  DropdownMenuItem(child: Text('Once a day'), value: '1x'),
                  DropdownMenuItem(child: Text('Twice a day'), value: '2x'),
                  DropdownMenuItem(child: Text('Thrice a day'), value: '3x'),
                ],
                onChanged: (frequencySelected) =>
                    context.read(frequencyProvider).state = frequencySelected),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: dosageController,
              decoration:
                  InputDecoration(labelText: 'Dosage', hintText: '2 pills'),
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
              onChanged: (reminderSet) =>
                  context.read(reminderSwitchProvider).state = reminderSet,
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
                    .createMedication(
                        userId: currUser,
                        medication: Medication(
                            dosage: dosageController.text,
                            frequency: frequencyValue.state,
                            medicationName: nameController.text,
                            treatmentLength: treatmentLengthController.text,
                            reminder: reminder,
                            medicationExpiry: DateTime.now()
                                .add(Duration(
                                    days: int.tryParse(
                                        treatmentLengthController.text)))
                                .toLocal()
                                .toString()
                                .split(' ')[0],
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
