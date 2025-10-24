import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/widgets/inventory_card.dart';

class InventoryList extends ConsumerStatefulWidget {
  const InventoryList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _InventoryListState();
  }
}

class _InventoryListState extends ConsumerState {
  late Future<void> _loadInventoriesFuture;

  @override
  void initState() {
    super.initState();
    _loadInventoriesFuture = ref
        .read(inventoryProvider.notifier)
        .loadInventories();
  }

  @override
  Widget build(BuildContext context) {
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
            FutureBuilder(
              future: _loadInventoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return inventories.isEmpty
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
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8),
                        );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
