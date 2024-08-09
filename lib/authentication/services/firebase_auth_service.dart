import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../services/user_manager.dart';

class FirebaseAuthService {
  var logger = Logger();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        await handleSignInSuccess();
      } else {
        // Handle unexpected null user
        // Display an error message or log the issue
      }

      return credential.user;
    } catch (e) {
      // Handle Firebase Authentication errors
      // Display user-friendly error messages or log the issue
      print("Sign up with email and password Error: $e");
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        await handleSignInSuccess();
      } else {
        print("No user is signed in.");
        // Handle unexpected null user
        // Display an error message or log the issue
      }
      return credential.user;
    } catch (e) {
      // Handle Firebase Authentication errors
      // Display user-friendly error messages or log the issue
      print("Sign in with email and password Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    UserManager.logoutUser();
    await _firebaseAuth.signOut();
  }

  Future<void> handleSignInSuccess() async {
    final user = _firebaseAuth.currentUser;
    print(user);

    if (user != null) {
      logger.i("SignIn Success");
      // await Future.delayed(const Duration(seconds: 1));

      try {
        final u = await UserManager.userLoggedIn(user);
        // Update user role or perform other actions
        print("ccv user: $u");
      } catch (e) {
        // Handle user-related errors
        // Display user-friendly error messages or log the issue
        logger.e(e.toString());
      }

      // Navigate to the home page or perform other post-sign-in actions
    } else {
      // Handle case where no user is signed in
      // Display an error message or take appropriate action
      logger.e("No user is signed in.");
    }
  }
}
