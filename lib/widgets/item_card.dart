import 'dart:io';

import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/data/models/item/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, this.inventoryColor});

  final Item item;
  final Color? inventoryColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor:
          inventoryColor?.withValues(alpha: 0.16) ??
          colorScheme.surfaceContainerHighest,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: item.imagePath != null
            ? Image.file(
                File(item.imagePath!),
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/images/placeholder.jpg',
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
      ),
      title: Text(
        item.name,
        style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${item.measurementValue} * ${item.measureUnit.text}",
        style: textTheme.bodyMedium,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.favorite, color: colorScheme.primary, size: 32),
      ),
      onTap: () {
        print("object");
      },
    );
  }
}
