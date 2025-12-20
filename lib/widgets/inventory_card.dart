import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/models/inventory.dart';
import 'package:ethircle_blk_app/models/inventory_use.dart';
import 'package:ethircle_blk_app/theme.dart';

class InventoryCard extends StatelessWidget {
  const InventoryCard({super.key, required this.inventory});

  final Inventory inventory;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final useColor = InventoryUse.values
        .firstWhere((use) => use.displayName == inventory.use)
        .displayColor;

    return GestureDetector(
      onTap: () {
        // Handle card tap if needed
      },
      child: Card(
        color: colorScheme.surfaceContainerLowest,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: useColor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 8),
              Text(inventory.name, style: title4Style),
              const Spacer(),
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
