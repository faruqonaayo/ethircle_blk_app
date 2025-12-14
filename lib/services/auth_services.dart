import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ethircle_blk_app/models/blk_user.dart';

class AuthServices {
  static Future<Map<String, dynamic>> createBlkUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection("users").add({
        "uid": FirebaseAuth.instance.currentUser?.uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      final newUser = BlkUser(
        uid: FirebaseAuth.instance.currentUser?.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      return {"status": "success", "user": newUser};
    } on FirebaseAuthException catch (e) {
      return {"status": "error", "message": e.message};
    }
  }

  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in user with Firebase Authentication
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user details from Firestore
      final querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return {"status": "error", "message": "User not found"};
      }

      final doc = querySnapshot.docs.first;
      final data = doc.data();

      final loggedInUser = BlkUser(
        uid: authResult.user?.uid,
        firstName: data['firstName'],
        lastName: data['lastName'],
        email: data['email'],
      );

      return {"status": "success", "user": loggedInUser};
    } on FirebaseAuthException catch (e) {
      return {"status": "error", "message": e.message};
    }
  }
}
