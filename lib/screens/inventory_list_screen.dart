import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/theme.dart';
import 'package:ethircle_blk_app/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/widgets/inventory_card.dart';

class InventoryListScreen extends ConsumerWidget {
  const InventoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventories = ref.watch(inventoryProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListView(
        children: [
          Row(
            children: [
              Text('Inventories', style: title1Style),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (inventories.isEmpty)
            Center(child: const Text('No inventories available'))
          else
            ...inventories.map(
              (inventory) => InventoryCard(inventory: inventory),
            ),
        ],
      ),
    );
  }
}
