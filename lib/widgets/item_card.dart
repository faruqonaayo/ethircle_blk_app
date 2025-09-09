import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/items_provider.dart';
import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/models/item.dart';

class ItemCard extends ConsumerWidget {
  const ItemCard({super.key, required this.category, required this.item});

  final Item item;
  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final itemsNotifier = ref.read(itemsProvider.notifier);

    // this function helps to prevent users from making item deletion by mistake
    Future<bool?> showDeletionAlert() async {
      return showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete ${item.name}"),
          actions: [
            IconButton(
              onPressed: () {
                itemsNotifier.removeItem(item.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${item.name} deleted successfully")),
                );
                Navigator.of(ctx).pop(true);
              },
              icon: Icon(Icons.check, color: Colors.green),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              icon: Icon(Icons.close, color: Colors.red),
            ),
          ],
        ),
      );
    }

    return Dismissible(
      key: ValueKey(item),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        return showDeletionAlert();
      },
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade50,
              Colors.red.shade100,
              Colors.red.shade200,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Icon(Icons.delete, color: Colors.red.shade500)],
        ),
      ),
      child: Card(
        elevation: 0,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: colorScheme.primary.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          splashColor: Color.fromRGBO(
            category.rValue,
            category.gValue,
            category.bValue,
            0.1,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(40),
                    child: Image.asset("assets/fan.jpg", width: 80, height: 80),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.name.length > 10
                      ? "${item.name.substring(0, 10)}..."
                      : item.name,
                  style: textTheme.headlineSmall!.copyWith(
                    color: colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description.length > 50
                      ? "${item.description.substring(0, 40)}..."
                      : item.description,
                  style: textTheme.bodySmall!.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                Text(
                  "more info >",
                  style: TextStyle(
                    fontSize: 10,
                    color: colorScheme.tertiary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
