import 'package:ethircle_blk_app/data/database/local_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'package:ethircle_blk_app/data/models/inventory.dart';

final uuid = Uuid();

class InventoryService {
  static Inventory createNewInventory({
    required String name,
    required String description,
    required String type,
    required String use,
    required int rColor,
    required int gColor,
    required int bColor,
  }) {
    return Inventory(
      id: uuid.v4(),
      name: name,
      description: description,
      type: type,
      use: use,
      rColor: rColor,
      gColor: gColor,
      bColor: bColor,
    );
  }

  final _localDb = LocalDb();

  Future<void> addInventory(Inventory inventory) async {
    final db = await _localDb.database;

    try {
      await db.insert('inventories', {
        'id': inventory.id,
        'name': inventory.name,
        'description': inventory.description,
        'type': inventory.type,
        'use': inventory.use,
        'rColor': inventory.rColor,
        'gColor': inventory.gColor,
        'bColor': inventory.bColor,
      });
      return;
    } catch (e) {
      print("Error adding inventory: $e");
      return;
    }
  }
}
