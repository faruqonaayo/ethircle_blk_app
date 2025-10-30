import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';

class AppDataNotifier extends Notifier<Map<String, dynamic>> {
  @override
  Map<String, dynamic> build() => {"appInitialized": false};

  Future<void> loadAppData() async {
    // loading inventories or any other app data can be done here
    await ref.read(inventoryProvider.notifier).loadInventories();
    state = {...state, "appInitialized": true};
  }
}

final appDataProvider = NotifierProvider(AppDataNotifier.new);
