import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/inventory.dart';

class InventoryNotifier extends Notifier<List<Inventory>> {
  @override
  build() {
    return [];
  }

  Future<void> loadInventories() async {
    // fetch inventories from a data source
    final db = FirebaseFirestore.instance;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    // Query inventories where userId == uid
    final response = await db
        .collection("inventories")
        .where("userId", isEqualTo: uid)
        .get();

    state = response.docs
        .map(
          (doc) => Inventory(
            id: doc.id,
            name: doc["name"],
            description: doc["description"],
            use: doc["use"],
            userId: doc["userId"],
          ),
        )
        .toList();
  }

  void addInventory(Inventory inventory) {
    state = [...state, inventory];
  }

  void deleteInventory(String inventoryId) {
    state = state.where((inv) => inv.id != inventoryId).toList();
  }
}

final inventoryProvider = NotifierProvider<InventoryNotifier, List<Inventory>>(
  InventoryNotifier.new,
);
