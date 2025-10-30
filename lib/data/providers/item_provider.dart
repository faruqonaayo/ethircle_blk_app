import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/services/item_service.dart';
import 'package:ethircle_blk_app/data/models/item/item.dart';

class ItemNotifier extends Notifier<List<Item>> {
  @override
  List<Item> build() {
    return [];
  }

  Future<void> loadItems() async {
    try {
      final response = await ItemService.getAllItems();
      state = response;
    } catch (e) {
      state = [];
    }
  }

  void addItem(Item item) {
    state = [...state, item];
  }

  List<Item> findItemsByInventoryId(String? inventoryId) {
    if (inventoryId == null) return [];

    final filteredItems = state
        .where((item) => item.inventoryId == inventoryId)
        .toList();

    return filteredItems;
  }
}

final itemProvider = NotifierProvider<ItemNotifier, List<Item>>(
  ItemNotifier.new,
);
