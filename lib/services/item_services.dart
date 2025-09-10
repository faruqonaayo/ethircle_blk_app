import 'dart:io';

import 'package:path_provider/path_provider.dart' as syspath;

import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/services/db_services.dart';

class ItemServices {
  static void addItem(Item item) async {
    final db = await DbServices.db;

    final itemMap = {
      "id": item.id,
      "name": item.name,
      "description": item.description,
      "worth": item.worth,
      "address": item.address,
      "image_url": item.imageUrl,
      "cat_id": item.catId,
      "is_favorite": item.isFavorite ? 1 : 0,
      "created_at": item.createdAt.toIso8601String(),
      "updated_at": item.updatedAt.toIso8601String(),
    };

    await db.insert("item", itemMap);
  }

  static void updateItem(String itemId, Item item) async {
    final db = await DbServices.db;
    final itemMap = {
      "id": item.id,
      "name": item.name,
      "description": item.description,
      "worth": item.worth,
      "address": item.address,
      "image_url": item.imageUrl,
      "cat_id": item.catId,
      "is_favorite": item.isFavorite ? 1 : 0,
      "created_at": item.createdAt.toIso8601String(),
      "updated_at": DateTime.now().toIso8601String(),
    };
    await db.update("item", itemMap, where: "id = ?", whereArgs: [itemId]);
  }

  static void deleteItem(String itemId) async {
    final db = await DbServices.db;
    await db.delete("item", where: "id = ?", whereArgs: [itemId]);
  }

  static Future<String> saveImage(File image) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final extension = image.path.split(".").last;

    final imagePath =
        "${appDir.path}/${DateTime.now().microsecondsSinceEpoch.toString()}.$extension";

    final savedImage = await image.copy(imagePath);
    return savedImage.path;
  }
}
