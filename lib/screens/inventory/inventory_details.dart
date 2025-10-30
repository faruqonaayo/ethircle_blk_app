import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final inventoryColor = _inventory == null
        ? null
        : Color.fromRGBO(
            _inventory!.rColor,
            _inventory!.gColor,
            _inventory!.bColor,
            0.5,
          );
    return Scaffold(
      appBar: AppBar(
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
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.info_outline)),
        ],
        backgroundColor: inventoryColor,
      ),
      body: widget.inventoryId == null
          ? Center(child: Text("No Inventory Found"))
          : _buildCategoryDetails(_inventory!),
    );
  }

  Widget _buildCategoryDetails(Inventory inventory) {
    final inventoryItems = ref
        .read(itemProvider.notifier)
        .findItemsByInventoryId(_inventory?.id);

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildPageHeader(inventory),
        const SizedBox(height: 32),
        ...inventoryItems.map(
          (item) => ListTile(
            leading: item.imagePath != null
                ? Image.file(
                    File(item.imagePath!),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.inventory_2),
            title: Text(item.name),
          ),
        ),
      ],
    );
  }

  Widget _buildPageHeader(Inventory inventory) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      inventory.name,
      style: textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      textAlign: TextAlign.center,
    );
  }
}
