import 'package:ethircle_blk_app/services/item_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/items_provider.dart';
import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/screens/item_form_screen.dart';

class ItemDetailsScreen extends ConsumerStatefulWidget {
  const ItemDetailsScreen(this.item, {super.key});

  final Item item;

  @override
  ConsumerState<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends ConsumerState<ItemDetailsScreen> {
  late Item _item;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final itemsNotifier = ref.read(itemsProvider.notifier);

    Widget createAppBar() {
      return SliverAppBar(
        title: Text(
          "Item Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              // obtaining the result of the update
              final result = await Navigator.of(context).push<Item>(
                MaterialPageRoute(
                  builder: ((ctx) => ItemFormScreen(isEditing: _item)),
                ),
              );

              // seetting the result of the update to the new value
              if (result != null) {
                setState(() {
                  _item = result;
                });
              }
            },
          ),
        ],
        flexibleSpace: SizedBox(
          child: Stack(
            children: [
              Image.asset(
                "assets/fan.jpg",
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              Container(
                width: double.infinity,
                height: double.infinity,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(0, 0, 0, 0.6),
                      const Color.fromRGBO(0, 0, 0, 0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
        expandedHeight: 320,
      );
    }

    Widget createPageContent() {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _item.name,
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _item.isFavorite = !_item.isFavorite;
                      });
                      itemsNotifier.setFavorite(_item.id, _item.isFavorite);
                      ItemServices.updateItem(_item.id, _item);

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _item.isFavorite
                                ? 'Added to favorites'
                                : 'Removed from favorites',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: Icon(
                      _item.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Colors.red,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "\$${_item.worth}",
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: colorScheme.primary,
                ),
              ),
              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 232, 232, 232),
                height: 32,
              ),
              Text(
                "Description",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _item.description,
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.secondary,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Address",
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _item.address,
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.secondary,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(slivers: [createAppBar(), createPageContent()]),
    );
  }
}
