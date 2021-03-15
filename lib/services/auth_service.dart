import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_tracker/services/service_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final Reader _reader;
  AuthService(this._reader);

  Stream<User> get authStateChanges =>
      _reader(firebaseAuthProvider).authStateChanges();

  Future<void> anonymLogin() async =>
      await _reader(firebaseAuthProvider).signInAnonymously();

  Future<User> getCurrentAnonymUser() async {
    return _reader(firebaseAuthProvider).currentUser;
  }

  Future<void> anonymSignOut() async =>
      await _reader(firebaseAuthProvider).signOut();
}
