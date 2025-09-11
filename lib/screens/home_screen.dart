import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/widgets/chart_analysis.dart';
import 'package:ethircle_blk_app/providers/categories_provider.dart';
import 'package:ethircle_blk_app/providers/items_provider.dart';
import 'package:ethircle_blk_app/widgets/overall_information.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsProvider);
    final categories = ref.watch(categoriesProvider);
    final favorites = items.where((item) => item.isFavorite).toList();

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        OverallInformation(
          categories: categories,
          items: items,
          favorites: favorites,
        ),
        const SizedBox(height: 32),
        ChartAnalysis(
          categories: categories,
          items: items,
          favorites: favorites,
        ),

        
      ],
    );
  }
}
