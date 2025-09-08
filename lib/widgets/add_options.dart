import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/screens/category_form_screen.dart';
import 'package:ethircle_blk_app/screens/item_form_screen.dart';

class AddOptions extends StatelessWidget {
  const AddOptions({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          "Select the option you want to add",
          style: textTheme.headlineSmall!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _Option(
          label: "Add Item",
          icon: Icons.emoji_objects_outlined,
          page: ItemFormScreen(),
        ),
        const SizedBox(height: 8),
        _Option(
          label: "Add Category",
          icon: Icons.category_outlined,
          page: CategoryFormScreen(),
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({required this.label, required this.icon, required this.page});

  final String label;
  final IconData icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => page));
      },
      child: Row(
        children: [
          Icon(icon, size: 24, color: colorScheme.onSurface),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 16)),
          const Spacer(),
          Icon(Icons.chevron_right, size: 32, color: colorScheme.onSurface),
        ],
      ),
    );
  }
}
