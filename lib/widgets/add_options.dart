import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/theme.dart';

class AddOptions extends StatelessWidget {
  const AddOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
          Text("Select an option", style: title2),
          const SizedBox(height: 16),
          _buildOption("Add Item", context, null),
          const SizedBox(height: 16),
          _buildOption("Add Category", context, null),
        ],
      ),
    );
  }

  Widget _buildOption(String text, BuildContext context, Function? onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(Icons.emoji_objects_outlined),
      title: Text(text, style: TextStyle(fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.chevron_right),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          width: 1,
          color: colorScheme.primary.withValues(alpha: 0.4),
        ),
      ),
      onTap: onTap == null
          ? null
          : () {
              onTap();
            },
    );
  }
}
