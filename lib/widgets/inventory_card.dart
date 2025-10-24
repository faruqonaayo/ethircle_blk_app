import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/data/models/inventory.dart';

class InventoryCard extends StatelessWidget {
  final Inventory inventory;

  const InventoryCard({super.key, required this.inventory});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final inventoryTypeColor = inventory.type.color;
    final inventoryColor = Color.fromARGB(
      255,
      inventory.rColor,
      inventory.gColor,
      inventory.bColor,
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              inventoryTypeColor.withValues(alpha: 0.08),
              inventoryTypeColor.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),

        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          leading: Icon(
            inventory.use.icon,
            size: 18,
            color: inventoryColor.withValues(alpha: 0.6),
          ),
          title: Text(
            inventory.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall!.copyWith(color: inventoryTypeColor),
          ),
          trailing: Icon(Icons.chevron_right, color: inventoryTypeColor),
          onTap: () {},
        ),
      ),
    );
  }
}
