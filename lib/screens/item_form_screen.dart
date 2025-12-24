import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/providers/item_provider.dart';
import 'package:ethircle_blk_app/services/item_services.dart';
import 'package:ethircle_blk_app/models/measure_unit.dart';
import 'package:ethircle_blk_app/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/models/inventory.dart';
import 'package:ethircle_blk_app/theme.dart';
import 'package:ethircle_blk_app/widgets/input_field.dart';

class ItemFormScreen extends ConsumerStatefulWidget {
  const ItemFormScreen({super.key});

  @override
  ConsumerState<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends ConsumerState<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredDescription = '';
  var _enteredPrice = 0.0;
  Inventory? _selectedInventory;
  MeasureUnit _selectedMeasureUnit = MeasureUnit.values.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        children: [
          Text('Add Item', style: title1Style, textAlign: TextAlign.left),
          SizedBox(height: 8),
          Text(
            'Fill in the details to add a new item',
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                InputField(
                  initialValue: _enteredName,
                  labelText: "Name",
                  hintText: "Enter item name",
                  validatorFn: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item name.';
                    }
                    return null;
                  },
                  saveFn: (value) {
                    _enteredName = value!;
                  },
                ),
                InputField(
                  initialValue: _enteredDescription,
                  labelText: "Description",
                  hintText: "Enter item description",
                  validatorFn: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item description.';
                    }
                    return null;
                  },
                  saveFn: (value) {
                    _enteredDescription = value!;
                  },
                  maxLines: 4,
                ),
                InputField(
                  initialValue: _enteredPrice.toString(),
                  labelText: "Price",
                  hintText: "Enter item price",
                  keyboardType: TextInputType.number,
                  validatorFn: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item price.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    }
                    return null;
                  },
                  saveFn: (value) {
                    _enteredPrice = double.parse(value!);
                  },
                ),
                InputField(
                  initialValue: _enteredPrice.toString(),
                  labelText: "Quantity",
                  hintText: "Enter item quantity",
                  keyboardType: TextInputType.number,
                  validatorFn: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter item quantity.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    }
                    return null;
                  },
                  saveFn: (value) {
                    _enteredPrice = double.parse(value!);
                  },
                ),
                DropdownButtonFormField(
                  initialValue: _selectedMeasureUnit,
                  items: _buildMeasureUnitDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMeasureUnit = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Measure Unit",
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
                DropdownButtonFormField(
                  initialValue: _selectedInventory,
                  items: _buildInvDropdownItems(),
                  onChanged: (value) {
                    setState(() {
                      _selectedInventory = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Inventory",
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
                    child: Text('Save Item'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem> _buildInvDropdownItems() {
    final inventories = ref.watch(inventoryProvider);
    return [
      DropdownMenuItem(value: null, child: Text('Select Inventory')),
      ...inventories.map(
        (inv) => DropdownMenuItem(value: inv, child: Text(inv.name)),
      ),
    ];
  }

  List<DropdownMenuItem> _buildMeasureUnitDropdownItems() {
    return [
      ...MeasureUnit.values.map(
        (inv) => DropdownMenuItem(value: inv, child: Text(inv.displayName)),
      ),
    ];
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    // saving new item logic here
    final newItem = Item(
      name: _enteredName,
      description: _enteredDescription,
      price: _enteredPrice,
      measureUnit: _selectedMeasureUnit.displayName,
      inventoryId: _selectedInventory?.id ?? '',
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    // logic to add or update item
    late final Map<String, dynamic> response;

    response = await ItemServices.addItem(newItem);

    if (!mounted) return;

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Item saved successfully!')));

      final itemProviderNotifier = ref.read(itemProvider.notifier);
      itemProviderNotifier.addItem(newItem);

      Navigator.of(context).pop();
    } else {
      final errorMessage = response['message'] ?? 'An error occurred.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }
}
