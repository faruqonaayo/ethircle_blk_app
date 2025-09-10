import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/items_provider.dart';
import 'package:ethircle_blk_app/widgets/item_card.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final allItems = ref.watch(itemsProvider);
    final favoriteItems = allItems.where((item) => item.isFavorite).toList();

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          "Favorites",
          style: textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Explore your favorite items here",
          style: textTheme.bodyLarge!.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),
        favoriteItems.isEmpty
            ? Center(child: Text("No favorite items yet!"))
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
                itemCount: favoriteItems.length,
                itemBuilder: (ctx, index) {
                  final currentItem = favoriteItems[index];
                  return ItemCard(item: currentItem);
                },
              ),
      ],
    );
  }
}
