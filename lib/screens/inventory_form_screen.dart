import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/inventory_use.dart';
import 'package:ethircle_blk_app/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/models/inventory.dart';
import 'package:ethircle_blk_app/services/inventory_services.dart';
import 'package:ethircle_blk_app/theme.dart';
import 'package:ethircle_blk_app/widgets/input_field.dart';

class InventoryFormScreen extends ConsumerStatefulWidget {
  const InventoryFormScreen({super.key});

  @override
  ConsumerState<InventoryFormScreen> createState() =>
      _InventoryFormScreenState();
}

class _InventoryFormScreenState extends ConsumerState<InventoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredDescription = '';
  var _selectedUse = InventoryUse.values.first;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    // saving new inventory logic here
    final newInventory = Inventory(
      name: _enteredName,
      description: _enteredDescription,
      use: _selectedUse.displayName,
    );

    final response = await InventoryServices.addInventory(newInventory);
    if (!mounted) return;

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Inventory added successfully!')));

      final inventoryProviderNotifier = ref.read(inventoryProvider.notifier);
      inventoryProviderNotifier.addInventory(response['data'] as Inventory);

      Navigator.of(context).pop();
    } else {
      final errorMessage = response['message'] ?? 'An error occurred.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        children: [
          Text('Add Inventory', style: title1Style, textAlign: TextAlign.left),
          SizedBox(height: 8),
          Text(
            'Fill in the details to add a new inventory',
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                InputField(
                  labelText: "Name",
                  hintText: "Enter inventory name",
                  validatorFn: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter inventory name.';
                    }
                    return null;
                  },
                  saveFn: (value) {
                    _enteredName = value!;
                  },
                ),
                InputField(
                  labelText: "Description",
                  hintText: "Enter inventory description",
                  validatorFn: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter inventory description.';
                    }
                    return null;
                  },
                  saveFn: (value) {
                    _enteredDescription = value!;
                  },
                  maxLines: 4,
                ),
                DropdownButtonFormField(
                  initialValue: _selectedUse,
                  items: _buildDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUse = value as InventoryUse;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Inventory Use",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    fillColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHigh,
                    filled: true,
                  ),
                  dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _trySubmit();
                    },
                    child: Text('Save Inventory'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem> _buildDropdownItems() {
    return InventoryUse.values
        .map(
          (use) => DropdownMenuItem(value: use, child: Text(use.displayName)),
        )
        .toList();
  }
}
