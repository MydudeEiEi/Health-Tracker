// Import the required packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController {
  static User? user = FirebaseAuth.instance.currentUser;

  static Future<User?> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();

    final googleAuth = await googleAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    // Save the user's email and uid to Firestore after signing in
    saveUserToFirestore(userCredential.user);

    return userCredential.user;
  }

  // Create a separate method for saving the user's email and uid to Firestore
  static Future<void> saveUserToFirestore(User? user) async {
    // Get the user's email and uid
    String? email = user?.email;
    String? uid = user?.uid;

    // Create a reference to the users collection in Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Save the user's email and uid to Firestore using their uid as the document id
    users
        .doc(uid)
        .set({
          'email': email,
          'uid': uid,
        })
        .then((value) => print("User added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static Future<bool> signOutConfirmation(BuildContext? context) async {
    if (context == null) return false;

    final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Logout Confirmation"),
            content: Text("Do you want to logout?"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("No")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Yes")),
            ],
          );
        });

    return confirmed ?? false;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
