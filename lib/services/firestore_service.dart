import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/models/medication_model.dart';
import 'package:med_tracker/services/service_providers.dart';

abstract class BaseMedicationClass {
  Future<List<Medication>> readMedications({@required String userId});
  Future<void> createMedication(
      {@required String userId, @required Medication medication});
  Future<void> updateMedication(
      {@required String userId,
      @required Medication medication,
      @required String medicationId});
  Future<void> deleteMedication(
      {@required String userId, @required String medicationId});
  Future<void> readSingleMedication(
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
        .add(medication.toJson())
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
  // ignore: missing_return
  Future<List<Medication>> readMedications({String userId}) async {
    try {
      final medList = await _reader(firestoreProvider)
          .collection('medications')
          .doc(userId)
          .collection('userMedications')
          .get();
      return medList.docs
          .map((doc) => Medication.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> updateMedication(
      {String userId, Medication medication, String medicationId}) async {
    await _reader(firestoreProvider)
        .collection('medications')
        .doc(userId)
        .collection('userMedications')
        .doc(medicationId)
        .update(medication.toJson());
  }

  @override
  Future<void> readSingleMedication({String userId, String medicationId}) {
    return _reader(firestoreProvider)
        .collection('medications')
        .doc(userId)
        .collection('userMedications')
        .doc(medicationId)
        .get();
  }
}
