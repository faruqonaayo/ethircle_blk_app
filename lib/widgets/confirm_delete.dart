import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  const ConfirmDelete({super.key, required this.onConfirm, required this.name});

  final Function() onConfirm;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: Text(
        'Are you sure you want to delete $name? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            onConfirm(); // Call the confirm callback
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
