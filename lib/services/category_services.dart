import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/services/db_services.dart';

class CategoryServices {
  static void addCategory(Category category) async {
    final db = await DbServices.db;

    final categoryMap = {
      "id": category.id,
      "name": category.name,
      "description": category.description,
      "a_value": category.aValue,
      "r_value": category.rValue,
      "g_value": category.gValue,
      "b_value": category.bValue,
      "created_at": category.createdAt.toIso8601String(),
      "updated_at": category.updatedAt.toIso8601String(),
    };

    await db.insert("category", categoryMap);
  }

  static void updateCategory(String catId, Category category) async {
    final db = await DbServices.db;
    final categoryMap = {
      "id": category.id,
      "name": category.name,
      "description": category.description,
      "a_value": category.aValue,
      "r_value": category.rValue,
      "g_value": category.gValue,
      "b_value": category.bValue,
      "created_at": category.createdAt.toIso8601String(),
      "updated_at": category.updatedAt.toIso8601String(),
    };
    await db.update(
      "category",
      categoryMap,
      where: "id = ?",
      whereArgs: [catId],
    );
  }

  static void deleteCategory(String catId) async {
    final db = await DbServices.db;
    await db.delete("category", where: "id = ?", whereArgs: [catId]);
  }
}
