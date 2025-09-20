import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/blk_user.dart';

class UserNotifier extends StateNotifier<BlkUser?> {
  UserNotifier() : super(null);

  Future<void> loadUser() async {
    final response = await FirebaseFirestore.instance
        .collection("users")
        .where("userUID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    final doc = response.docs[0];

    state = BlkUser(
      firstName: doc["firstName"],
      lastName: doc["lastName"],
      email: doc["email"],
      userUID: doc["userUID"],
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, BlkUser?>(
  (ref) => UserNotifier(),
);
