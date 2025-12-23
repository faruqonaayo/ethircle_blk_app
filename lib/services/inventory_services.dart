import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ethircle_blk_app/models/inventory.dart';

class InventoryServices {
  static Future<Map<String, dynamic>> addInventory(Inventory inventory) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("inventories")
          .add({
            'name': inventory.name,
            'description': inventory.description,
            'use': inventory.use,
            'userId': inventory.userId,
          });

      final newInventory = Inventory(
        id: result.id,
        name: inventory.name,
        description: inventory.description,
        use: inventory.use,
        userId: inventory.userId,
      );

      return {"status": "success", "data": newInventory};
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> deleteInventory(String inventoryId) async {
    try {
      await FirebaseFirestore.instance
          .collection("inventories")
          .doc(inventoryId)
          .delete();

      return {"status": "success"};
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }
}
