import 'dart:convert';

List<Medication> MedicationFromJson(str) => List<Map<String, dynamic>>.from(str)
    .map((e) => Medication.fromJson(e))
    .toList(growable: false);

Medication bookFromJson(String str) => Medication.fromJson(json.decode(str));

String MedicationToJson(List<Medication> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Medication {
  final String medicationName;
  final String frequency;
  final String dosage;
  final String treatmentLength;
  final bool reminder;
  final DateTime uploadTimeStamp = DateTime.now().toLocal();

  Medication(
      {this.medicationName,
      this.frequency,
      this.dosage,
      this.treatmentLength,
      this.reminder,
      uploadTimeStamp});

  factory Medication.fromJson(Map<String, dynamic> snapshot) => Medication(
        medicationName: snapshot['medicationName'] ?? '',
        frequency: snapshot['frequency'] ?? '',
        dosage: snapshot['dosage'] ?? '',
        treatmentLength: snapshot['treatmentLength'] ?? '',
        reminder: snapshot['reminder'] ?? false,
        uploadTimeStamp:
            snapshot['uploadTimeStamp'] ?? DateTime.now().toLocal(),
      );

  Map<String, dynamic> toJson() => {
        'medicationName': medicationName,
        'frequency': frequency,
        'dosage': dosage,
        'treatmentLength': treatmentLength,
        'reminder': reminder,
        'uploadTimeStamp': uploadTimeStamp
      };
}
