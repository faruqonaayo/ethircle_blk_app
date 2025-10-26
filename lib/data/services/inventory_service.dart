import 'package:uuid/uuid.dart';

import 'package:ethircle_blk_app/data/database/local_db.dart';
import 'package:ethircle_blk_app/data/models/inventory_type.dart';
import 'package:ethircle_blk_app/data/models/inventory_use.dart';
import 'package:ethircle_blk_app/data/models/inventory.dart';

final uuid = Uuid();

class InventoryService {
  static Inventory createNewInventory({
    required String name,
    required String description,
    required InventoryType type,
    required InventoryUse use,
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

  static final _localDb = LocalDb();

  static Future<List<Inventory>> getAllInventories() async {
    final db = await _localDb.database;
    final List<Map<String, dynamic>> maps = await db.query('inventories');

    return List.generate(maps.length, (i) {
      return Inventory(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        type: InventoryType.values.firstWhere(
          (e) => e.name == maps[i]['type'],
          orElse: () => InventoryType.consumable,
        ),
        use: InventoryUse.values.firstWhere(
          (e) => e.name == maps[i]['use'],
          orElse: () => InventoryUse.personal,
        ),
        rColor: maps[i]['rColor'],
        gColor: maps[i]['gColor'],
        bColor: maps[i]['bColor'],
      );
    });
  }

  static Future<void> addInventory(Inventory inventory) async {
    final db = await _localDb.database;

    try {
      await db.insert('inventories', {
        'id': inventory.id,
        'name': inventory.name,
        'description': inventory.description,
        'type': inventory.type.name,
        'use': inventory.use.name,
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

  static Future<void> deleteInventory(String id) async {
    final db = await _localDb.database;

    try {
      await db.delete(
        'inventories',
        where: 'id = ?',
        whereArgs: [id],
      );
      return;
    } catch (e) {
      print("Error deleting inventory: $e");
      return;
    }
  }
}
