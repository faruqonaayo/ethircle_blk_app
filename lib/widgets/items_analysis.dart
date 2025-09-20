import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemsAnalysis extends StatefulWidget {
  const ItemsAnalysis(this.items, {super.key});

  final List<Item> items;

  @override
  State<ItemsAnalysis> createState() => _ItemsAnalysisState();
}

class _ItemsAnalysisState extends State<ItemsAnalysis> {
  var _title = "";
  var _displayItem = [];

  void _recentItem() {
    if (widget.items.isNotEmpty) {
      setState(() {
        _title = "The most recent item is...";
        _displayItem = [
          widget.items.reduce(
            (value, item) =>
                item.updatedAt.isAfter(value.updatedAt) ? item : value,
          ),
        ];
      });
    }
  }

  void _oldestItem() {
    if (widget.items.isNotEmpty) {
      setState(() {
        _title = "The oldest item is...";
        _displayItem = [
          widget.items.reduce(
            (value, item) =>
                item.updatedAt.isBefore(value.updatedAt) ? item : value,
          ),
        ];
      });
    }
  }

  void _mostValuableItem() {
    if (widget.items.isNotEmpty) {
      setState(() {
        _title = "The most valuable item is...";
        _displayItem = [
          widget.items.reduce(
            (value, item) => item.worth > value.worth ? item : value,
          ),
        ];
      });
    }
  }

  void _leastValuableItem() {
    if (widget.items.isNotEmpty) {
      _title = "The least valuable item is...";
      setState(() {
        _displayItem = [
          widget.items.reduce(
            (value, item) => item.worth < value.worth ? item : value,
          ),
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _recentItem();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 416,
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
                TextButton(onPressed: _recentItem, child: Text("Recent Items")),
                TextButton(onPressed: _oldestItem, child: Text("Oldest Item")),
                TextButton(
                  onPressed: _mostValuableItem,
                  child: Text("Most Valuable Item"),
                ),
                TextButton(
                  onPressed: _leastValuableItem,
                  child: Text("Least Valuable Item"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _title,
            style: textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          _displayItem.isEmpty
              ? Center(child: Text("No items yet"))
              : Card(
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: colorScheme.primary.withValues(alpha: 0.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _displayItem[0].imageUrl == ""
                            ? Image.asset(
                                "assets/demo.jpg",
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                _displayItem[0].imageUrl,
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                        const SizedBox(height: 16),
                        Text(
                          _displayItem[0].name,
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
