import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:ethircle_blk_app/services/item_services.dart';
import 'package:ethircle_blk_app/theme.dart';
import 'package:ethircle_blk_app/widgets/confirm_delete.dart';
import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/providers/item_provider.dart';

class ItemScreen extends ConsumerWidget {
  const ItemScreen(this.itemId, {super.key});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final item = ref
        .watch(itemProvider)
        .firstWhere(
          (itm) => itm.id == itemId,
          orElse: () => Item(
            name: "Unknown",
            description: "No description available.",
            price: 0.0,
            quantity: 0,
            measureUnit: "",
            inventoryId: "",
            userId: "",
          ),
        );

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // 🌄 Image Header
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            elevation: 0,
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 110,
                    color: colorScheme.outline.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite, color: Colors.redAccent),
              ),
              IconButton(
                onPressed: () {
                  // Handle edit item
                  context.push('/item/edit/${item.id}');
                },
                icon: Icon(Icons.edit, color: colorScheme.onSurfaceVariant),
              ),

              IconButton(
                onPressed: () {
                  // Handle delete item
                  showDialog(
                    context: context,
                    builder: (ctx) => ConfirmDelete(
                      onConfirm: () async {
                        // Delete item logic here
                        ref.read(itemProvider.notifier).deleteItem(item.id!);
                        await ItemServices.deleteItem(itemId);
                        if (!context.mounted) return;
                        context.pop();
                      },
                      name: item.name,
                    ),
                  );
                },
                icon: Icon(Icons.delete, color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),

          // 📄 Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: title1Style),

                  const SizedBox(height: 8),

                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: title3Style.copyWith(color: colorScheme.primary),
                  ),

                  const SizedBox(height: 32),

                  // 📝 Description Section
                  Text('Description', style: title3Style),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 36),

                  Row(
                    children: [
                      _detailCard(
                        context,
                        icon: Icons.inventory_2_outlined,
                        label: 'Quantity',
                        value: '${item.quantity}',
                      ),
                      const SizedBox(width: 14),
                      _detailCard(
                        context,
                        icon: Icons.straighten,
                        label: 'Unit',
                        value: item.measureUnit,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary),
            const SizedBox(height: 14),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
