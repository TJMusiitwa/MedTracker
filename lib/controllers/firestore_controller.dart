import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/models/medication_model.dart';
import 'package:med_tracker/services/service_providers.dart';

class FirestoreController extends StateNotifier<AsyncValue<List<Medication>>> {
  final Reader _reader;
  final String userId;

  FirestoreController(this._reader, this.userId) : super(AsyncValue.loading()) {
    if (userId != null) {
      retrieveMedications();
      //streamMedications();
    }
  }

  Future<void> retrieveMedications({bool isRefreshing = false}) async {
    if (isRefreshing) state = AsyncValue.loading();
    final medications =
        await _reader(firestoreService).readMedications(userId: userId);
    if (mounted) {
      state = AsyncValue.data(medications);
    }
  }

  Stream<void> streamMedications() {
    final medications =
        _reader(firestoreService).streamMedications(userId: userId);
    if (mounted) {
      state = medications as AsyncValue<List<Medication>>;
    }
  }
}
