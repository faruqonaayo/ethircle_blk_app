import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/models/inventory.dart';
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
  var _searchText = "";

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
                } else if (inventories.isEmpty) {
                  return Center(
                    child: Text(
                      'No inventories added yet.',
                      style: textTheme.bodyMedium,
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSearchField(),
                      const SizedBox(height: 16),
                      buildInventoryList(inventories),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Inventories',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
    );
  }

  Widget buildInventoryList(List<Inventory> inventories) {
    final displayedInventories = _searchText.isEmpty
        ? inventories
        : inventories
              .where(
                (inv) =>
                    inv.name.toLowerCase().contains(_searchText.toLowerCase()),
              )
              .toList();

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayedInventories.length,
      itemBuilder: (context, index) {
        return InventoryCard(inventory: displayedInventories[index]);
      },
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }
}
