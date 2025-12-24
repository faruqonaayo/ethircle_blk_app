import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/providers/item_provider.dart';

final appDataProvider = Provider<Future<void>>((ref) async {
  // Initialize and fetch any global app data here if needed
  final inventoriesNotifier = ref.read(inventoryProvider.notifier);
  final itemsNotifier = ref.read(itemProvider.notifier);

  await inventoriesNotifier.loadInventories();
  await itemsNotifier.loadItems();

  return;
});
