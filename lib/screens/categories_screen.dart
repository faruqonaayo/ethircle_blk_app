import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/widgets/category_card.dart';
import 'package:ethircle_blk_app/providers/categories_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          "Categories",
          style: textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 32),
        categories.isEmpty
            ? Center(child: Text("No categories yet!"))
            : ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (ctx, index) => CategoryCard(categories[index]),
              ),
      ],
    );
  }
}
