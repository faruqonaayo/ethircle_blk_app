import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemNotifier extends Notifier<List<Item>> {
  @override
  build() {
    return [];
  }

  void addItem(Item item) {
    state = [...state, item];
  }
}

final itemProvider = NotifierProvider<ItemNotifier, List<Item>>(
  ItemNotifier.new,
);
