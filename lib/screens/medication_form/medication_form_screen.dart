import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/screens/medication_form/medication_form_providers.dart';

class MedicationFormScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var nameController = watch(medicationNameEntryController);
    var dosageController = watch(dosageEntryController);
    var otherDetailsController = watch(otherDetailsEntryController);
    var reminder = watch(reminderSwitchProvider).state;
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
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your medication';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Frequency'),
                iconEnabledColor: Theme.of(context).accentColor,
                items: [
                  DropdownMenuItem(child: Text('Once'), value: '1'),
                  DropdownMenuItem(child: Text('Twice'), value: '2'),
                  DropdownMenuItem(child: Text('Thrice'), value: '3'),
                ],
                onChanged: (frequencySelected) => print(frequencySelected)),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: dosageController,
              decoration:
                  InputDecoration(labelText: 'Dosage', hintText: '2 pills'),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: otherDetailsController,
              decoration: InputDecoration(labelText: 'Other Details'),
              maxLines: 3,
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
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
