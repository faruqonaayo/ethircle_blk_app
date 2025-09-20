import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ethircle_blk_app/models/blk_user.dart';

class UserServices {
  static void updateProfile(BlkUser updatedData) async {
    final authUser = FirebaseAuth.instance.currentUser;

    if (authUser == null) {
      return;
    }
    await FirebaseFirestore.instance
        .collection("users")
        .doc(updatedData.userID)
        .update({
          "firstName": updatedData.firstName,
          "lastName": updatedData.lastName,
        });
  }

  static Future<Map?> updatePassword(String newPassword) async {
    final authUser = FirebaseAuth.instance.currentUser;

    if (authUser == null) {
      return null;
    }
    try {
      await authUser.updatePassword(newPassword);
      return {"status": "Success"};
    } on FirebaseAuthException catch (_) {
      FirebaseAuth.instance.signOut();
      return null;
    }
  }
}
