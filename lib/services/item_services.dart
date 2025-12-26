import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemServices {
  static Future<Map<String, dynamic>> addItem(Item item) async {
    try {
      await FirebaseFirestore.instance.collection("items").add({
        'name': item.name,
        'description': item.description,
        'price': item.price,
        'quantity': item.quantity,
        'measureUnit': item.measureUnit,
        'inventoryId': item.inventoryId,
        'userId': item.userId,
      });

      return {"status": "success", "data": item};
    } catch (e) {
      return {"status": "error", "message": e.toString()};
    }
  }
}
