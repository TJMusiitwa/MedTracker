import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_tracker/services/service_providers.dart';

class AuthController extends StateNotifier<User> {
  final Reader _reader;

  StreamSubscription<User> _authStateChangeSubscription;

  AuthController(this._reader) : super(null) {
    _authStateChangeSubscription.cancel();
    _authStateChangeSubscription = _reader(authServiceProvider)
        .authStateChanges
        .listen((user) => state = user);
  }

  @override
  void dispose() {
    _authStateChangeSubscription.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _reader(authServiceProvider).getCurrentAnonymUser();

    if (user == null) {
      await _reader(authServiceProvider).anonymLogin();
    }
  }

  void appSignOut() async {
    await _reader(authServiceProvider).anonymSignOut();
  }
}
