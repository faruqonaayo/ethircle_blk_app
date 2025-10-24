import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/models/inventory.dart';

class InventoryNotifier extends Notifier<List<Inventory>> {
  @override
  List<Inventory> build() => [];

  void addInventory(Inventory inventory) {
    state = [...state, inventory];
  }
}

final inventoryProvider = NotifierProvider<InventoryNotifier, List<Inventory>>(
  InventoryNotifier.new,
);
