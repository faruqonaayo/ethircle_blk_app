import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/category.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]);

  static final _fireStore = FirebaseFirestore.instance;
  static final _fireAuth = FirebaseAuth.instance;

  Future<void> loadCategories() async {
    final response = await _fireStore
        .collection("categories")
        .where("userID", isEqualTo: _fireAuth.currentUser!.uid)
        .get();

    final categories = response.docs;

    for (var cat in categories) {
      state = [
        ...state,
        Category(
          id: cat.id,
          name: cat["name"] as String,
          description: cat["description"] as String,
          aValue: cat["aValue"] as double,
          rValue: cat["rValue"] as int,
          gValue: cat["gValue"] as int,
          bValue: cat["bValue"] as int,
          createdAt: DateTime.parse(cat["createdAt"] as String),
          updatedAt: DateTime.parse(cat["updatedAt"] as String),
        ),
      ];
    }
  }

  void addNewCategory(Category cat) {
    state = [...state, cat];
  }

  void removeCategory(String catId) {
    state = state.where((cat) => cat.id != catId).toList();
  }

  void editCategory(Category editedCategory) {
    state = state.map((cat) {
      if (cat.id == editedCategory.id) {
        return editedCategory;
      } else {
        return cat;
      }
    }).toList();
  }

  List<Category> searchCategory(String query) {
    final lowerQuery = query.toLowerCase();

    if (lowerQuery == "") {
      return state;
    }
    return state
        .where(
          (cat) =>
              cat.name.toLowerCase().contains(lowerQuery) ||
              cat.description.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}

final categoriesProvider = StateNotifierProvider((ref) => CategoriesNotifier());
