import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/screens/category_details_screen.dart';
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
  var _showSearchInput = false;
  var _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final categories = ref
        .read(categoriesProvider.notifier)
        .searchCategory(_searchQuery);

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Text(
              "Categories",
              style: textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 2,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showSearchInput = !_showSearchInput;
                      });
                    },
                    icon: Icon(Icons.search),
                    color: colorScheme.primary,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => CategoryDetailsScreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.list, color: colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _showSearchInput
            ? TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  label: Text("Search"),
                  border: OutlineInputBorder(),
                ),
              )
            : SizedBox.shrink(),
        const SizedBox(height: 32),
        categories.isEmpty
            ? Center(child: Text("No categories yet!"))
            : TweenAnimationBuilder(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInCubic,
                tween: Tween(begin: 64.0, end: 0.0),
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (ctx, index) => CategoryCard(categories[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                ),
                builder: (_, value, myChild) => Padding(
                  padding: EdgeInsetsGeometry.only(top: value),
                  child: myChild,
                ),
              ),
      ],
    );
  }
}
