import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemsAnalysis extends StatelessWidget {
  const ItemsAnalysis(this.items, {super.key});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 384,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(126, 187, 255, 210),
                  ),
                  child: const Icon(Icons.info, size: 16, color: Colors.green),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "Items Analysis",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                TextButton(onPressed: () {}, child: Text("Recent Items")),
                TextButton(onPressed: () {}, child: Text("Oldest Item")),
                TextButton(onPressed: () {}, child: Text("Most Valuable Item")),
                TextButton(
                  onPressed: () {},
                  child: Text("Least Valuable Item"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,

            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: colorScheme.primary),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/demo.jpg",
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Items Analysis",
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
