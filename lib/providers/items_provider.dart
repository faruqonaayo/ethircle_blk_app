import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemsNotifier extends StateNotifier<List<Item>> {
  ItemsNotifier() : super([]);

  static final _fireStore = FirebaseFirestore.instance;
  static final _fireAuth = FirebaseAuth.instance;

  Future<void> loadItems() async {
    final response = await _fireStore
        .collection("items")
        .where("userID", isEqualTo: _fireAuth.currentUser!.uid)
        .get();

    final items = response.docs;

    state = items
        .map(
          (item) => Item(
            id: item.id,
            name: item["name"] as String,
            description: item["description"] as String,
            worth: item["worth"] as double,
            address: item["address"] as String,
            imageUrl: item["imageUrl"] as String,
            catId: item["catId"] as String?,
            lat: item["lat"] as double?,
            long: item["long"] as double?,
            isFavorite: (item["isFavorite"] as int) == 1 ? true : false,
            createdAt: DateTime.parse(item["createdAt"] as String),
            updatedAt: DateTime.parse(item["updatedAt"] as String),
          ),
        )
        .toList();

    return;
  }

  void addNewItem(Item item) {
    state = [...state, item];
  }

  void removeItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  void editItem(Item editedItem) {
    state = state.map((item) {
      if (item.id == editedItem.id) {
        return editedItem;
      } else {
        return item;
      }
    }).toList();
  }

  void setFavorite(String itemId, bool value) {
    state = state.map((item) {
      if (item.id == itemId) {
        item.isFavorite = value;
      }
      return item;
    }).toList();
  }
}

final itemsProvider = StateNotifierProvider((ref) => ItemsNotifier());
