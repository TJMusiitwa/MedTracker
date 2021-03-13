import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
