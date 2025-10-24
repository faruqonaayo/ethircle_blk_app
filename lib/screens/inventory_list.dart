import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/widgets/inventory_card.dart';

class InventoryList extends ConsumerWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventories = ref.watch(inventoryProvider);

    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inventory List', style: textTheme.titleMedium),
            const SizedBox(height: 16),
            inventories.isEmpty
                ? Center(
                    child: Text(
                      'No inventories added yet.',
                      style: textTheme.bodyMedium,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: inventories.length,
                    itemBuilder: (context, index) {
                      return InventoryCard(inventory: inventories[index]);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                  ),
          ],
        ),
      ),
    );
  }
}
