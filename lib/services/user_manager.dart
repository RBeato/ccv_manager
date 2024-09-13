import 'package:ccv_manager/services/firebase_storing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firedart/auth/user_gateway.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ccv_user.dart';

const String _isLoggedIn = 'isLoggedIn';
const String _name = 'name';
const String _id = 'id';
const String _email = 'email';
const String _role = 'role';
const String _authId = 'authId';

class UserManager {
  static Future<CCVUser?> userLoggedIn(User user) async {
    try {
      const storage = FlutterSecureStorage();
      FirestoreService firestoreService = FirestoreService();

      // Fetch documents from Firestore
      QuerySnapshot querySnapshot =
          await firestoreService.getAll(FirestoreCollection.users);

      // Check if the user's UID is among the authIds in the Firestore documents
      QueryDocumentSnapshot? matchingDoc;
      try {
        matchingDoc = querySnapshot.docs.firstWhere(
          (doc) => doc['authId'] == user.uid,
        );
      } catch (e) {
        print(e);
      }

      // Iterate over the documents and find the one that matches the user's UID
      if (matchingDoc != null) {
        // Found a matching document, create a CCVUser instance
        CCVUser ccvUser = CCVUser.fromSnapshot(matchingDoc);

        // Optionally, you can save user details to SharedPreferences
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool(_isLoggedIn, true);
        pref.setString(_name, ccvUser.name);
        pref.setString(_id, ccvUser.id);
        pref.setString(_email, ccvUser.email);
        pref.setString(_role, ccvUser.role);
        pref.setString(_authId, ccvUser.authId);

        return ccvUser;
      } else {
        // No matching document found, log the error and sign the user out
        print('Error: No matching user found in Firestore');
        await FirebaseAuth.instance.signOut();
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static checkUserState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogged = pref.getBool(_isLoggedIn) ?? false;
    print('Is Logged: $isLogged'); // Log to validate
    return isLogged;
  }

  static getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return CCVUser(
      id: pref.getString(_id) ?? '',
      name: pref.getString(_name) ?? '',
      email: pref.getString(_email) ?? '',
      role: pref.getString(_role) ?? '',
      authId: pref.getString(_authId) ?? '',
    );
  }

  static logoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    pref.clear();
  }

  // Consider adding a method to UserManager to check Firebase auth state and update SharedPreferences
  static Future<void> syncUserState() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      // User is logged in, update SharedPreferences
      await userLoggedIn(firebaseUser);
    } else {
      // User is not logged in, clear SharedPreferences
      await logoutUser();
    }
  }
}
