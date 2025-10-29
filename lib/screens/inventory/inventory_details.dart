import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ethircle_blk_app/data/models/inventory.dart';
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
          : buildCategoryDetails(_inventory!),
    );
  }

  Widget buildCategoryDetails(Inventory inventory) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        buildPageHeader(inventory),
        const SizedBox(height: 32),
        Text("List of Items"),
      ],
    );
  }

  Widget buildPageHeader(Inventory inventory) {
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
