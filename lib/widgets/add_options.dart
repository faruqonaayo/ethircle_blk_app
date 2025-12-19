import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/theme.dart';

class AddOptions extends StatelessWidget {
  const AddOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(32),
      height: 320,
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose an option to add:',
            style: title3Style.copyWith(fontSize: 16),
          ),
          _buildOptionTile(context, 'Add Item', Icons.emoji_objects, () {
            // Handle add item action
          }),
          _buildOptionTile(context, 'Add Inventory', Icons.inventory, () {
            // Handle add category action
          }),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close, color: colorScheme.onError),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    String title,
    IconData icon,
    Function onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: colorScheme.primary),
      title: Text(title, style: title3Style),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(width: 1, color: colorScheme.primary),
      ),
      onTap: () {
        // Handle add category action
        onTap();
      },
    );
  }
}
