import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  FutureOr<User?> signUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException(errorMessage: 'The account already exists for that email.');
      } else {
        throw AuthException(errorMessage: 'Something went wrong!');
      }
    } catch (e) {
      throw AuthException(errorMessage: 'Something went wrong!');
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthException(errorMessage: 'Email or password is invalid');
      } else {
        throw AuthException(errorMessage: 'Something went wrong!');
      }
    } catch (e) {
      throw AuthException(errorMessage: 'Something went wrong!');
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (_) {
      throw AuthException(errorMessage: 'Something went wrong!');
    } catch (e) {
      throw AuthException(errorMessage: 'Something went wrong!');
    }
  }
}

class AuthException implements Exception {
  final String errorMessage;

  AuthException({required this.errorMessage});
}
