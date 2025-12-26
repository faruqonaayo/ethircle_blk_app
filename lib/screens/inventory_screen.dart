import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ethircle_blk_app/models/inventory_use.dart';
import 'package:ethircle_blk_app/widgets/item_card.dart';
import 'package:ethircle_blk_app/providers/item_provider.dart';
import 'package:ethircle_blk_app/services/inventory_services.dart';
import 'package:ethircle_blk_app/widgets/confirm_delete.dart';
import 'package:ethircle_blk_app/models/inventory.dart';
import 'package:ethircle_blk_app/theme.dart';
import 'package:ethircle_blk_app/providers/inventory_provider.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen(this.inventoryId, {super.key});

  final String inventoryId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  var _selectedTab = 'Items';

  @override
  Widget build(BuildContext context) {
    final inventories = ref.watch(inventoryProvider);
    final inventoryNotifier = ref.read(inventoryProvider.notifier);

    final inventory = inventories.firstWhere(
      (inv) => inv.id == widget.inventoryId,
      orElse: () => Inventory(
        name: 'Unknown',
        description: 'No description available.',
        use: 'N/A',
        userId: '',
      ),
    );
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(inventory.name),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/inventory/edit/${inventory.id}');
            },
            icon: Icon(Icons.edit, color: colorScheme.onSurfaceVariant),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => ConfirmDelete(
                  onConfirm: () {
                    // Delete inventory logic here
                    InventoryServices.deleteInventory(inventory.id!);
                    inventoryNotifier.deleteInventory(inventory.id!);
                    context.pop();
                  },
                  name: inventory.name,
                ),
              );
            },
            icon: Icon(Icons.delete, color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),

        children: [
          SegmentedButton(
            segments: [
              ButtonSegment(value: 'Items', label: Text('Items')),
              ButtonSegment(value: 'Details', label: Text('Details')),
            ],
            selected: {_selectedTab},
            onSelectionChanged: (newSelection) {
              setState(() {
                _selectedTab = newSelection.first;
              });
            },
            style: SegmentedButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerLowest,
              selectedForegroundColor: colorScheme.onSurface,
              textStyle: title4Style.copyWith(fontSize: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _selectedTab == 'Items'
              ? _buildItemsTab(inventory)
              : _buildDetailsTab(inventory),
        ],
      ),
    );
  }

  Widget _buildItemsTab(Inventory inventory) {
    final items = ref.watch(itemProvider);
    final invItems = items
        .where((item) => item.inventoryId == widget.inventoryId)
        .toList();

    final inventoryColor = InventoryUse.values
        .firstWhere(
          (use) => use.displayName == inventory.use,
          orElse: () => InventoryUse.others,
        )
        .displayColor;

    if (invItems.isEmpty) {
      return Center(child: const Text('No items in this inventory'));
    }
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2 / 1,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: invItems.length,
      itemBuilder: (ctx, index) {
        final item = invItems[index];
        return ItemCard(item, cardColor: inventoryColor);
      },
    );
  }

  Widget _buildDetailsTab(Inventory inventory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: title3Style),
        const SizedBox(height: 8),
        Text(inventory.description),
        const SizedBox(height: 16),
        Text('Use', style: title3Style),
        const SizedBox(height: 8),
        Text(inventory.use),
      ],
    );
  }
}
