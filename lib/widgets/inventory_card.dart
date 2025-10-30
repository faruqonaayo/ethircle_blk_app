import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ethircle_blk_app/widgets/confirm_delete.dart';
import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/data/services/inventory_service.dart';
import 'package:ethircle_blk_app/data/models/inventory/inventory.dart';

class InventoryCard extends ConsumerWidget {
  final Inventory inventory;

  const InventoryCard({super.key, required this.inventory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final inventoryTypeColor = inventory.type.color;
    final inventoryColor = Color.fromARGB(
      255,
      inventory.rColor,
      inventory.gColor,
      inventory.bColor,
    );

    return Dismissible(
      key: ValueKey(inventory.id),
      confirmDismiss: (direction) async {
        final result = await showDialog<bool>(
          context: context,
          builder: (ctx) {
            return ConfirmDelete(
              itemName: inventory.name,
              onConfirm: () {
                ref
                    .read(inventoryProvider.notifier)
                    .removeInventory(inventory.id);
                InventoryService.deleteInventory(inventory.id);
              },
            );
          },
        );

        if (!context.mounted) {
          return null;
        }

        if (result == true) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${inventory.name} deleted')));
        }

        return result;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.red.withValues(alpha: 0.8),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
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
            onTap: () {
              context.push("/inventory/${inventory.id}");
            },
          ),
        ),
      ),
    );
  }
}
