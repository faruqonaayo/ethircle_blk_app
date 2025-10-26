import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  final String itemName;
  final void Function() onConfirm;

  const ConfirmDelete({
    super.key,
    required this.itemName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete $itemName?'),
      content: Text(
        'Are you sure you want to delete $itemName? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(true);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
