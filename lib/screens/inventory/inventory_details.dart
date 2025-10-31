import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ethircle_blk_app/widgets/item_card.dart';
import 'package:ethircle_blk_app/data/providers/item_provider.dart';
import 'package:ethircle_blk_app/data/models/inventory/inventory.dart';
import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';

class InventoryDetails extends ConsumerStatefulWidget {
  final String? inventoryId;

  const InventoryDetails({super.key, required this.inventoryId});

  @override
  ConsumerState<InventoryDetails> createState() => _InventoryDetailsState();
}

class _InventoryDetailsState extends ConsumerState<InventoryDetails> {
  late Inventory? _inventory;
  @override
  void initState() {
    super.initState();

    _inventory = _loadInventory();
  }

  Inventory? _loadInventory() {
    return ref
        .read(inventoryProvider.notifier)
        .findInventory(widget.inventoryId);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final inventoryColor = _inventory == null
        ? colorScheme.primary
        : Color.fromRGBO(
            _inventory!.rColor,
            _inventory!.gColor,
            _inventory!.bColor,
            1,
          );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(_inventory!),
          _buildInventoryInfo(_inventory!),
          _buildInventoryItems(_inventory!, inventoryColor),
        ],
      ),
    );
  }

  Widget _buildAppBar(Inventory inventory) {
    return SliverAppBar(
      expandedHeight: 200.0,
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Image.asset(
              'assets/images/banners/${inventory.use.name}.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              opacity: AlwaysStoppedAnimation(0.4),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  _buildPageHeader(inventory),
                  Row(
                    children: [
                      Text(
                        "Use:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        inventory.use.text,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Type:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        inventory.type.text,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            // Checking if an edit has being done so that we can change the inventory data state
            final result = await context.push<bool?>(
              "/edit-inventory/${widget.inventoryId}",
            );
            if (result == true) {
              setState(() {
                _inventory = _loadInventory();
              });
            }
          },
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }

  Widget _buildInventoryInfo(Inventory inventory) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              "Description:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(inventory.description, style: TextStyle(fontSize: 14)),
            Divider(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryItems(Inventory inventory, Color inventoryColor) {
    final inventoryItems = ref
        .read(itemProvider.notifier)
        .findItemsByInventoryId(_inventory?.id);

    return SliverFillRemaining(
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: inventoryItems.length,
        itemBuilder: (context, index) {
          final item = inventoryItems[index];
          return ItemCard(item: item, inventoryColor: inventoryColor);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 8);
        },
      ),
    );
  }

  Widget _buildPageHeader(Inventory inventory) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      inventory.name,
      style: textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}
