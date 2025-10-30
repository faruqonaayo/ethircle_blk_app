import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/services/inventory_service.dart';
import 'package:ethircle_blk_app/data/models/inventory/inventory.dart';

class InventoryNotifier extends Notifier<List<Inventory>> {
  @override
  List<Inventory> build() => [];

  Future<void> loadInventories() async {
    try {
      final response = await InventoryService.getAllInventories();
      state = response;
    } catch (e) {
      state = [];
    }
  }

  void addInventory(Inventory inventory) {
    state = [...state, inventory];
  }

  void removeInventory(String id) {
    state = state.where((inventory) => inventory.id != id).toList();
  }

  void updateInventory(Inventory updatedInventory) {
    state = [
      for (final inventory in state)
        if (inventory.id == updatedInventory.id)
          updatedInventory
        else
          inventory,
    ];
  }

  Inventory? findInventory(String? id) {
    if (id == null) return null;

    final filteredInventory = state
        .where((inventory) => inventory.id == id)
        .toList();

    return filteredInventory[0];
  }
}

final inventoryProvider = NotifierProvider<InventoryNotifier, List<Inventory>>(
  InventoryNotifier.new,
);
