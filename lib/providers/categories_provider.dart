import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/services/db_services.dart';
import 'package:ethircle_blk_app/models/category.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]);
  Future<void> loadCategories() async {
    final db = await DbServices.db;

    final categories = await db.query("category");

    for (var cat in categories) {
      state = [
        ...state,
        Category(
          id: cat["id"] as String,
          name: cat["name"] as String,
          description: cat["description"] as String,
          aValue: cat["a_value"] as double,
          rValue: cat["r_value"] as int,
          gValue: cat["g_value"] as int,
          bValue: cat["b_value"] as int,
          createdAt: DateTime.parse(cat["created_at"] as String),
          updatedAt: DateTime.parse(cat["updated_at"] as String),
        ),
      ];
    }
  }

  void addNewCategory(Category cat) {
    state = [...state, cat];
  }

  void removeCategory(String catId) {
    state = state.where((cat) => cat.id != catId).toList();
  }

  void editCategory(Category editedCategory) {
    state = state.map((cat) {
      if (cat.id == editedCategory.id) {
        return editedCategory;
      } else {
        return cat;
      }
    }).toList();
  }
}

final categoriesProvider = StateNotifierProvider((ref) => CategoriesNotifier());
