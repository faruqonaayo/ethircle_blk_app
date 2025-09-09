import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/category.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]);

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
