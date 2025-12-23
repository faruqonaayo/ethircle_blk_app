import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final inventory = inventories.firstWhere(
      (inv) => inv.id == widget.inventoryId,
    );
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(inventory.name)),
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
              ? _buildItemsTab()
              : _buildDetailsTab(inventory),
        ],
      ),
    );
  }

  Widget _buildItemsTab() {
    return Center(child: Text('Items Tab Content'));
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
