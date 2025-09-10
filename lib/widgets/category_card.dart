import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/services/category_services.dart';
import 'package:ethircle_blk_app/screens/category_details_screen.dart';
import 'package:ethircle_blk_app/providers/categories_provider.dart';
import 'package:ethircle_blk_app/models/category.dart';

class CategoryCard extends ConsumerWidget {
  const CategoryCard(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesNotifier = ref.read(categoriesProvider.notifier);
    final textTheme = Theme.of(context).textTheme;

    // this function helps to prevent users from making category deletion by mistake
    Future<bool?> showDeletionAlert() async {
      return showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete ${category.name}"),
          actions: [
            IconButton(
              onPressed: () {
                categoriesNotifier.removeCategory(category.id);
                CategoryServices.deleteCategory(category.id);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${category.name} deleted successfully"),
                  ),
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
      key: ValueKey(category),
      confirmDismiss: (direction) async {
        return showDeletionAlert();
      },
      direction: DismissDirection.horizontal,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          splashColor: Color.fromRGBO(
            category.rValue,
            category.gValue,
            category.bValue,
            0.32,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => CategoryDetailsScreen(category),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(
                    category.rValue,
                    category.gValue,
                    category.bValue,
                    0.16,
                  ),
                  Color.fromRGBO(
                    category.rValue,
                    category.gValue,
                    category.bValue,
                    0.07,
                  ),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Text(
                  category.name,
                  style: textTheme.bodyLarge!.copyWith(
                    color: Color.fromRGBO(
                      category.rValue,
                      category.gValue,
                      category.bValue,
                      1,
                    ),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  size: 32,
                  color: Color.fromRGBO(
                    category.rValue,
                    category.gValue,
                    category.bValue,
                    1,
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
