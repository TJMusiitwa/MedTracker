import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/medication_model.dart';
import 'package:med_tracker/services/service_providers.dart';

abstract class BaseMedicationClass {
  Future<List<Medication>> readMedication({@required String userId});
  Future<void> createMedication(
      {@required String userId, @required Medication medication});
  Future<void> updateMedication(
      {@required String userId, @required Medication medication});
  Future<void> deleteMedication(
      {@required String userId, @required String medicationId});
}

class FirestoreService implements BaseMedicationClass {
  final Reader _reader;
  FirestoreService(this._reader);

  @override
  Future<void> createMedication({String userId, Medication medication}) {
    return _reader(firestoreProvider)
        .collection('medications')
        .doc(userId)
        .collection('userMedications')
        .add({'medicationName': medication.medicationName})
        .then((value) => print(value.id))
        .catchError((error) => print('Failed to add medication: $error'));
  }

  @override
  Future<void> deleteMedication({String userId, String medicationId}) {
    return _reader(firestoreProvider)
        .collection('medications')
        .doc(userId)
        .collection('userMedications')
        .doc(medicationId)
        .delete();
  }

  @override
  Future<List<Medication>> readMedication({String userId}) async {
    try {
      final medList = await _reader(firestoreProvider)
          .collection('medications')
          .doc(userId)
          .collection('userMedications')
          .get();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> updateMedication({String userId, Medication medication}) {
    return _reader(firestoreProvider)
        .collection('medications')
        .doc(userId)
        .collection('userMedications')
        .doc(medication.dosage)
        .update({});
  }
}
