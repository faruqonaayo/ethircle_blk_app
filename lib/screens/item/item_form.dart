import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/widgets/image_field.dart';
import 'package:ethircle_blk_app/data/providers/item_provider.dart';
import 'package:ethircle_blk_app/data/services/item_service.dart';
import 'package:ethircle_blk_app/data/models/inventory/inventory.dart';
import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/data/models/item/measure_unit.dart';
import 'package:ethircle_blk_app/widgets/input_field.dart';

class ItemForm extends ConsumerStatefulWidget {
  const ItemForm({super.key});

  @override
  ConsumerState<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends ConsumerState<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  var _selectedUnit = MeasureUnit.values.first;
  var _enteredName = "";
  var _enteredDescription = "";
  double _enteredMeasurementValue = 0.0;
  double _enteredPricePerUnit = 0.0;
  Inventory? _selectedInventory = null;
  File? _selectedImage;
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
          _pageHeader(context),
          SizedBox(height: 24),
          _pageForm(context),
        ],
      ),
    );
  }

  Widget _pageHeader(BuildContext context) {
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

  Widget _pageForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          InputField(
            label: "Item Name",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter a Name";
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredName = newValue!.trim();
            },
          ),
          InputField(
            minLines: 3,
            maxLines: 5,
            label: "Item Description",
            onSaved: (newValue) {
              _enteredDescription = newValue!.trim();
            },
          ),
          DropdownButtonFormField(
            initialValue: _selectedUnit,
            decoration: InputDecoration(labelText: "Measure Unit"),
            dropdownColor: colorScheme.primaryContainer,

            items: MeasureUnit.values
                .map((unit) => _buildDropdownItem(unit, unit.text))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedUnit = value!;
              });
            },
          ),
          InputField(
            initialValue: _enteredMeasurementValue.toString(),
            keyboardType: TextInputType.number,
            label: "Measurement Value",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter a Measurement Value";
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredMeasurementValue =
                  double.tryParse(newValue!.trim()) ?? 0.0;
            },
          ),
          InputField(
            initialValue: _enteredPricePerUnit.toString(),
            keyboardType: TextInputType.number,
            label: "Price per Unit",
            prefixText: "\$ ",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter a Price per Unit";
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredPricePerUnit = double.tryParse(newValue!.trim()) ?? 0.0;
            },
          ),
          DropdownButtonFormField(
            initialValue: null,
            decoration: InputDecoration(labelText: "Inventory"),
            dropdownColor: colorScheme.primaryContainer,
            items: [
              DropdownMenuItem(value: null, child: Text("Select Inventory")),
              ..._inventories.map(
                (inventory) => _buildDropdownItem(inventory, inventory.name),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedInventory = value;
              });
            },
          ),
          ImageField(
            onImageSelected: (image) {
              setState(() {
                _selectedImage = image;
              });
            },
          ),

          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _onSubmit,
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

  DropdownMenuItem _buildDropdownItem(Object value, String displayText) {
    return DropdownMenuItem(value: value, child: Text(displayText));
  }

  void _onSubmit() {
    final formState = _formKey.currentState!;
    if (!formState.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final newItem = ItemService.createNewItem(
      name: _enteredName,
      description: _enteredDescription,
      measureUnit: _selectedUnit,
      measurementValue: _enteredMeasurementValue,
      pricePerUnit: _enteredPricePerUnit,
      inventoryId: _selectedInventory?.id,
      imagePath: _selectedImage?.path,
    );

    final itemNotifier = ref.read(itemProvider.notifier);

    // updating state
    itemNotifier.addItem(newItem);

    // adding to database
    ItemService.addItem(newItem);

    // showing user the success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item '${newItem.name}' added successfully!")),
    );

    formState.reset();
  }
}
