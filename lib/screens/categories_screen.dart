import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/widgets/category_card.dart';
import 'package:ethircle_blk_app/providers/categories_provider.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends ConsumerState<CategoriesScreen> {
  late Future<void> _loadCategories;

  @override
  void initState() {
    super.initState();
    final categoriesNotifier = ref.read(categoriesProvider.notifier);
    _loadCategories = categoriesNotifier.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: _loadCategories,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

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
                : ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (ctx, index) =>
                        CategoryCard(categories[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                  ),
          ],
        );
      },
    );
  }
}
