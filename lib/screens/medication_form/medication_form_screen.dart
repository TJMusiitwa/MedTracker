import 'package:flutter/material.dart';

class MedicationFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              decoration:
                  InputDecoration(labelText: 'Dosage', hintText: '2 pills'),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Other Details'),
              maxLines: 3,
            ),
            SizedBox(
              height: 15,
            ),
            SwitchListTile.adaptive(
              title: Text('Reminder'),
              value: true,
              onChanged: (reminderSet) {},
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
