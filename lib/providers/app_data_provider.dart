import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/items_provider.dart';
import 'package:ethircle_blk_app/providers/categories_provider.dart';

final appDataProvider = Provider<Future<void>>((ref) async {
  final categoriesNotifier = ref.read(categoriesProvider.notifier);
  await categoriesNotifier.loadCategories();
  final itemsNotifier = ref.read(itemsProvider.notifier);
  await itemsNotifier.loadItems();
  return;
});
