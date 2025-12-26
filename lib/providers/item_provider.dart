import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemNotifier extends Notifier<List<Item>> {
  @override
  build() {
    return [];
  }

  Future<void> loadItems() async {
    // optimization: avoid fetching if already loaded
    if (state.isNotEmpty) return;
    // fetch items from a data source
    final db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    // Query items where userId == uid
    final response = await db
        .collection("items")
        .where("userId", isEqualTo: uid)
        .get();

    state = response.docs
        .map(
          (doc) => Item(
            id: doc.id,
            name: doc["name"],
            description: doc["description"],
            price: doc["price"],
            quantity: doc["quantity"],
            measureUnit: doc["measureUnit"],
            inventoryId: doc["inventoryId"],
            userId: doc["userId"],
          ),
        )
        .toList();
  }

  void addItem(Item item) {
    state = [...state, item];
  }

  void deleteItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }
}

final itemProvider = NotifierProvider<ItemNotifier, List<Item>>(
  ItemNotifier.new,
);
