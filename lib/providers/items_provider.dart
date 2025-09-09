import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemsNotifier extends StateNotifier<List<Item>> {
  ItemsNotifier() : super([]);

  void addNewItem(Item item) {
    state = [...state, item];
  }

  void removeItem(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  void editItem(Item editedItem) {
    state = state.map((item) {
      if (item.id == editedItem.id) {
        return editedItem;
      } else {
        return item;
      }
    }).toList();
  }
}

final itemsProvider = StateNotifierProvider((ref) => ItemsNotifier());
