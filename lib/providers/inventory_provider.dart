import 'package:ethircle_blk_app/models/inventory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InventoryNotifier extends Notifier<List<Inventory>> {
  @override
  build() {
    return [];
  }

  void addInventory(Inventory inventory) {
    state = [...state, inventory];
  }
}

final inventoryProvider = NotifierProvider<InventoryNotifier, List<Inventory>>(
  InventoryNotifier.new,
);
