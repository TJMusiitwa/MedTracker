import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/medication_model.dart';

class FirestoreController extends StateNotifier<AsyncValue<List<Medication>>> {
  final Reader _reader;
  final String userId;

  FirestoreController(this._reader, this.userId) : super(AsyncValue.loading());
}
