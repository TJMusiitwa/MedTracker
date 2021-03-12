import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_tracker/controllers/auth_controller.dart';
import 'package:med_tracker/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Initialise global instance of FirebaseAuth
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

//Initialise global instance of Firestore
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

//To allow us access throughout the application
final authServiceProvider =
    Provider<AuthService>((ref) => AuthService(ref.read));

final authStateProvider = StreamProvider<User>(
    (ref) => ref.watch(authServiceProvider).authStateChanges);

final authContollerProvider = StateNotifierProvider<AuthController>(
    (ref) => AuthController(ref.read)..appStarted());
