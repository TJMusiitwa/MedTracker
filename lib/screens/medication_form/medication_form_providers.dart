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

final otherDetailsEntryController =
    Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController(text: '');
});

final reminderSwitchProvider = StateProvider<bool>((ref) => false);
