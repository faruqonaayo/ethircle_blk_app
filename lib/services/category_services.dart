import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ethircle_blk_app/models/category.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryServices {
  static final _fireStore = FirebaseFirestore.instance;
  static final _fireAuth = FirebaseAuth.instance;

  static Future<String> addCategory(Category category) async {
    final categoryMap = {
      "name": category.name,
      "description": category.description,
      "aValue": category.aValue,
      "rValue": category.rValue,
      "gValue": category.gValue,
      "bValue": category.bValue,
      "createdAt": category.createdAt.toIso8601String(),
      "updatedAt": category.updatedAt.toIso8601String(),
    };

    final response = await _fireStore.collection("categories").add({
      ...categoryMap,
      "userID": _fireAuth.currentUser!.uid,
    });

    return response.id;
  }

  static void updateCategory(String catId, Category category) async {
    final categoriesCollection = _fireStore.collection("categories");
    final categoryDoc = await categoriesCollection.doc(catId).get();

    if (categoryDoc.exists &&
        categoryDoc.data()?["userID"] == _fireAuth.currentUser!.uid) {
      final categoryMap = {
        "name": category.name,
        "description": category.description,
        "aValue": category.aValue,
        "rValue": category.rValue,
        "gValue": category.gValue,
        "bValue": category.bValue,
        "createdAt": category.createdAt.toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
      };
      categoriesCollection.doc(catId).update(categoryMap);
    }
  }

  static void deleteCategory(String catId) async {
    final categoriesCollection = _fireStore.collection("categories");
    final categoryDoc = await categoriesCollection.doc(catId).get();

    if (categoryDoc.exists &&
        categoryDoc.data()?["userID"] == _fireAuth.currentUser!.uid) {
      categoriesCollection.doc(catId).delete();
    }
  }
}
