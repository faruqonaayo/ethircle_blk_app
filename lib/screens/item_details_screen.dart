import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/screens/item_form_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen(this.item, {super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    Widget createAppBar() {
      return SliverAppBar(
        title: Text(
          "Item Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: ((ctx) => ItemFormScreen())));
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
                    item.name,
                    style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.favorite, color: Colors.red, size: 32),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "\$${item.worth}",
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
                item.description,
                style: textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.secondary,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Address",
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.address,
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
