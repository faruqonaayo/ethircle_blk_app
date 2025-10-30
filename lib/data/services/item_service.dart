import 'package:ethircle_blk_app/data/database/local_db.dart';
import 'package:ethircle_blk_app/data/services/inventory_service.dart';
import 'package:ethircle_blk_app/data/models/item/item.dart';
import 'package:ethircle_blk_app/data/models/item/measure_unit.dart';

class ItemService {
  static Item createNewItem({
    required String name,
    String? description,
    required MeasureUnit measureUnit,
    required double measurementValue,
    required double pricePerUnit,
    String? inventoryId,
  }) {
    return Item(
      id: uuid.v4(),
      name: name,
      description: description,
      measureUnit: measureUnit,
      measurementValue: measurementValue,
      pricePerUnit: pricePerUnit,
      inventoryId: inventoryId,
    );
  }

  static Item createUpdatedItem({
    required String id,
    required String name,
    String? description,
    required MeasureUnit measureUnit,
    required double measurementValue,
    required double pricePerUnit,
    String? inventoryId,
  }) {
    return Item(
      id: id,
      name: name,
      description: description,
      measureUnit: measureUnit,
      measurementValue: measurementValue,
      pricePerUnit: pricePerUnit,
      inventoryId: inventoryId,
    );
  }

  static final _localDb = LocalDb();

  static Future<List<Item>> getAllItems() async {
    final db = await _localDb.database;
    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        measureUnit: MeasureUnit.values.firstWhere(
          (e) => e.toString() == maps[i]['measureUnit'],
        ),
        measurementValue: maps[i]['measurementValue'] as double,
        pricePerUnit: maps[i]['pricePerUnit'] as double,
        inventoryId: maps[i]['inventoryId'],
      );
    });
  }

  static Future<void> addItem(Item item) async {
    final db = await _localDb.database;
    try {
      await db.insert('items', {
        'id': item.id,
        'name': item.name,
        'description': item.description,
        'measureUnit': item.measureUnit.toString(),
        'measurementValue': item.measurementValue,
        'pricePerUnit': item.pricePerUnit,
        'inventoryId': item.inventoryId,
      });
    } catch (e) {
      print('Error adding item: $e');
      return;
    }
  }
}
