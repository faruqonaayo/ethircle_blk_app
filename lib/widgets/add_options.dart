import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddOptions extends StatelessWidget {
  const AddOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          containerHeader(context),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.emoji_objects_outlined),
            title: Text(
              "Add New Item",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.chevron_right, size: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              Navigator.of(context).pop();
              context.push("/new-item");
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: Icon(Icons.inventory_outlined),
            title: Text(
              "Add New Inventory",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.chevron_right, size: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () {
              Navigator.of(context).pop();
              context.push("/new-inventory");
            },
          ),
        ],
      ),
    );
  }

  Widget containerHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          "Choose an option to add:",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
            color: Colors.red,
            size: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
