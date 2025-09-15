import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/models/item.dart';

class ChartAnalysis extends ConsumerWidget {
  const ChartAnalysis({
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

    return Container(
      height: 320,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
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
                    color: Color.fromARGB(126, 250, 255, 187),
                  ),
                  child: const Icon(
                    Icons.analytics,
                    size: 16,
                    color: Color.fromARGB(255, 243, 159, 33),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "Charts and Diagrams",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Check out the visualizations of you items",
            style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          items.isEmpty
              ? Center(
                  child: Text(
                    "Click the add button and start adding new items",
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
                    ),
                  ),
                )
              : Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: _MyPieChart(
                        containerColor: const Color.fromARGB(32, 105, 240, 175),
                        sectionData: [
                          PieChartSectionData(
                            value: favorites.length.toDouble(),
                            color: const Color.fromARGB(197, 255, 193, 7),
                            title: "Favorites",
                            radius: 10,
                          ),
                          PieChartSectionData(
                            value: (items.length - favorites.length).toDouble(),
                            color: const Color.fromARGB(203, 155, 39, 176),
                            title: "Non Favorites",
                            radius: 10,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _MyPieChart(
                        containerColor: const Color.fromARGB(22, 240, 105, 141),
                        sectionData: [
                          PieChartSectionData(
                            value: items
                                .where((item) => item.catId != null)
                                .length
                                .toDouble(),
                            color: const Color.fromARGB(158, 7, 255, 102),
                            title: "Categorized",
                            radius: 10,
                          ),
                          PieChartSectionData(
                            value: items
                                .where((item) => item.catId == null)
                                .length
                                .toDouble(),
                            color: const Color.fromARGB(202, 117, 176, 39),
                            title: "Non Categorized",
                            radius: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _MyPieChart extends StatelessWidget {
  const _MyPieChart({required this.containerColor, required this.sectionData});

  final Color containerColor;
  final List<PieChartSectionData> sectionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: PieChart(
        PieChartData(
          centerSpaceRadius: double.infinity,
          startDegreeOffset: 48,
          sections: sectionData,
        ),
        duration: Duration(milliseconds: 150), // Optional
        curve: Curves.linear, // Optional
      ),
    );
  }
}
