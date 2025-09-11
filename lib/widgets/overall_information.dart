import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/widgets/information_card.dart';

class OverallInformation extends ConsumerWidget {
  const OverallInformation({
    super.key,
    required this.categories,
    required this.items,
    required this.favorites,
  });

  final List<Category> categories;
  final List<Item> items;
  final List<Item> favorites;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final totalWorth = items.isNotEmpty
        ? items.map((item) => item.worth).reduce((a, b) => a + b)
        : 0;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(127, 187, 207, 255),
                  ),
                  child: const Icon(Icons.info, size: 16, color: Colors.blue),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "Overall Information",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Tap to view card info...",
            style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          SizedBox(
            height: 96, // give it a fixed height
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InformationCard(
                  label: "Storage Worth",
                  value: totalWorth.floor(),
                  icon: Icons.monetization_on_outlined,
                ),
                InformationCard(
                  label: "Items",
                  value: items.length,
                  icon: Icons.emoji_objects_outlined,
                ),
                InformationCard(
                  label: "Categories",
                  value: categories.length,
                  icon: Icons.category_outlined,
                ),
                InformationCard(
                  label: "Favorites",
                  value: favorites.length,
                  icon: Icons.favorite_border,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
