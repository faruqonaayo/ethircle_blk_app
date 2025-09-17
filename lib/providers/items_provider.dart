import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/services/db_services.dart';
import 'package:ethircle_blk_app/models/item.dart';

class ItemsNotifier extends StateNotifier<List<Item>> {
  ItemsNotifier() : super([]);

  Future<void> loadItems() async {
    final db = await DbServices.db;

    final items = await db.query("item");

    state = items
        .map(
          (item) => Item(
            id: item["id"] as String,
            name: item["name"] as String,
            description: item["description"] as String,
            worth: item["worth"] as double,
            address: item["address"] as String,
            imageUrl: item["image_url"] as String,
            catId: item["cat_id"] as String?,
            lat: item["lat"] as double?,
            long: item["long"] as double?,
            isFavorite: (item["is_favorite"] as int) == 1 ? true : false,
            createdAt: DateTime.parse(item["created_at"] as String),
            updatedAt: DateTime.parse(item["updated_at"] as String),
          ),
        )
        .toList();

    return;
  }

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

  void setFavorite(String itemId, bool value) {
    state = state.map((item) {
      if (item.id == itemId) {
        item.isFavorite = value;
      }
      return item;
    }).toList();
  }
}

final itemsProvider = StateNotifierProvider((ref) => ItemsNotifier());
