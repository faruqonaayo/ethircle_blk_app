import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/theme.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(this.item, {super.key, this.cardColor = Colors.white});

  final Item item;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle item tap if needed
        context.push('/item/${item.id}');
      },
      child: Card(
        elevation: 1,
        shadowColor: cardColor.withValues(alpha: 0.12),
        color: cardColor.withValues(alpha: 0.24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 8,
                child: Text(
                  item.name,
                  style: title4Style.copyWith(letterSpacing: 1),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 8,
                child: Text(
                  'Qty: ${item.quantity}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                ),
              ),

              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // Handle favorite toggle
                    print("favorite tapped");
                  },
                  child: Icon(Icons.favorite, color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
