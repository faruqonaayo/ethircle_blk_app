import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/items_provider.dart';
import 'package:ethircle_blk_app/widgets/item_card.dart';
import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/screens/category_form_screen.dart';

class CategoryDetailsScreen extends ConsumerStatefulWidget {
  const CategoryDetailsScreen({this.category, super.key});

  final Category? category;

  @override
  ConsumerState<CategoryDetailsScreen> createState() =>
      _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends ConsumerState<CategoryDetailsScreen> {
  late Category? _category;
  @override
  void initState() {
    super.initState();
    _category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsProvider);
    final categoryItems = _category == null
        ? items
        : items.where((item) => item.catId == _category!.id).toList();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Category Details"),
        actions: [
          _category == null
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () async {
                    // obtaining the result of the update
                    final result = await Navigator.of(context).push<Category>(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            CategoryFormScreen(isEditing: _category),
                      ),
                    );
                    // seetting the result of the update to the new value
                    if (result != null) {
                      setState(() {
                        _category = result;
                      });
                    }
                  },
                  icon: Icon(Icons.edit),
                ),
        ],
        backgroundColor: _category == null
            ? const Color.fromARGB(57, 96, 125, 139)
            : Color.fromRGBO(
                _category!.rValue,
                _category!.gValue,
                _category!.bValue,
                0.4,
              ),
      ),
      body: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 480),
        curve: Curves.linear,
        tween: Tween(begin: 0.8, end: 1.0),
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            Text(
              _category == null ? "All Items" : _category!.name,
              style: textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _category == null ? "List of all Items" : _category!.description,
              style: textTheme.bodyLarge!.copyWith(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Category Items",
              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            categoryItems.isEmpty
                ? Center(child: Text("No items yet!"))
                : GridView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 240,
                    ),
                    itemCount: categoryItems.length,
                    itemBuilder: (ctx, index) {
                      final currentItem = categoryItems[index];
                      return ItemCard(category: _category, item: currentItem);
                    },
                  ),
          ],
        ),
        builder: (_, scale, myChild) =>
            Transform.scale(scale: scale, child: myChild),
      ),
    );
  }
}
