import 'dart:io';

import 'package:path_provider/path_provider.dart' as sys_path;
import 'package:path/path.dart' as path;

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
    String? imagePath,
  }) {
    return Item(
      id: uuid.v4(),
      name: name,
      description: description,
      measureUnit: measureUnit,
      measurementValue: measurementValue,
      pricePerUnit: pricePerUnit,
      inventoryId: inventoryId,
      imagePath: imagePath,
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
    String? imagePath,
  }) {
    return Item(
      id: id,
      name: name,
      description: description,
      measureUnit: measureUnit,
      measurementValue: measurementValue,
      pricePerUnit: pricePerUnit,
      inventoryId: inventoryId,
      imagePath: imagePath,
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
        imagePath: maps[i]['imagePath'],
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

      if (item.imagePath != null) {
        await _saveItemImage(item.id, item.imagePath!);
      }
    } catch (e) {
      print('Error adding item: $e');
      return;
    }
  }

  static Future<String> _saveItemImage(String itemId, String imagePath) async {
    final directory = await sys_path.getApplicationDocumentsDirectory();
    final extension = path.extension(path.basename(imagePath));
    final fileName = '${itemId}_image$extension';
    final newPath = '${directory.path}/$fileName';
    final imageFile = File(imagePath);
    await imageFile.copy(newPath);

    final db = await _localDb.database;
    try {
      await db.update(
        'items',
        {'imagePath': newPath},
        where: 'id = ?',
        whereArgs: [itemId],
      );
      return newPath;
    } catch (e) {
      print('Error saving item image: $e');
      throw Exception('Failed to save item image');
    }
  }
}
