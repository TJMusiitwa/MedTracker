import 'package:flutter/widgets.dart' show TextEditingController;
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Entry Ferm Providers
final medicationNameEntryController =
    Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController(text: '');
});

final dosageEntryController =
    Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController(text: '');
});

final treatmentLengthEntryController =
    Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController(text: '');
});

final reminderSwitchProvider = StateProvider.autoDispose<bool>((ref) => false);

final frequencyProvider = StateProvider<String>((ref) => '');

//Update Ferm Providers
final medicationNameUpdateController =
    Provider.autoDispose.family<TextEditingController, String>((ref, name) {
  return TextEditingController(text: name);
});

final dosageUpdateController =
    Provider.autoDispose.family<TextEditingController, String>((ref, dosage) {
  return TextEditingController(text: dosage);
});

final treatmentLengthUpdateController =
    Provider.autoDispose.family<TextEditingController, String>((ref, length) {
  return TextEditingController(text: length);
});

final reminderSwitchUpdateProvider =
    StateProvider.autoDispose.family<bool, bool>((ref, set) => set);

final frequencyUpdateProvider =
    StateProvider.family<String, String>((ref, value) => value);
