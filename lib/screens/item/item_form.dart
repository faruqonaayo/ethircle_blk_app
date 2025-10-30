import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/models/inventory.dart';
import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/data/models/measure_unit.dart';
import 'package:ethircle_blk_app/widgets/input_field.dart';

class ItemForm extends ConsumerStatefulWidget {
  const ItemForm({super.key});

  @override
  ConsumerState<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends ConsumerState<ItemForm> {
  var _selectedUnit = MeasureUnit.values.first;
  var _enteredName = "";
  var _enteredDescription = "";
  var _enteredMeasurementValue = "";
  var _enteredPricePerUnit = "";
  Inventory? _selectedInventory = null;
  late List<Inventory> _inventories;

  @override
  void initState() {
    super.initState();
    _inventories = ref.read(inventoryProvider);
    _selectedInventory = _inventories.isNotEmpty ? _inventories.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        children: [
          pageHeader(context),
          SizedBox(height: 24),
          pageForm(context),
        ],
      ),
    );
  }

  Widget pageHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Hey!",
          style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
        ),
        SizedBox(height: 8),
        Text(
          "Let's start filling up your \ninventory with a new item ",
          style: textTheme.titleMedium!.copyWith(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget pageForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          InputField(label: "Item Name"),
          InputField(minLines: 3, maxLines: 5, label: "Item Description"),
          DropdownButtonFormField(
            initialValue: _selectedUnit,
            decoration: InputDecoration(labelText: "Measure Unit"),
            dropdownColor: colorScheme.primaryContainer,

            items: MeasureUnit.values
                .map((unit) => buildDropdownItem(unit, unit.text))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedUnit = value!;
              });
            },
          ),
          InputField(
            keyboardType: TextInputType.number,
            label: "Measurement Value",
          ),
          InputField(
            keyboardType: TextInputType.number,
            label: "Price per Unit",
            prefixText: "\$ ",
          ),
          DropdownButtonFormField(
            initialValue: null,
            decoration: InputDecoration(labelText: "Inventory"),
            dropdownColor: colorScheme.primaryContainer,
            items: [
              DropdownMenuItem(value: null, child: Text("Select Inventory")),
              ..._inventories.map(
                (inventory) => buildDropdownItem(inventory, inventory.name),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedInventory = value;
              });
            },
          ),

          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
            ),
            label: Text("Add Item"),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem buildDropdownItem(Object value, String displayText) {
    return DropdownMenuItem(value: value, child: Text(displayText));
  }
}
