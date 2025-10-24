import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/data/services/inventory_service.dart';
import 'package:ethircle_blk_app/data/models/inventory_type.dart';
import 'package:ethircle_blk_app/data/models/inventory_use.dart';
import 'package:ethircle_blk_app/widgets/input_field.dart';

class InventoryForm extends ConsumerStatefulWidget {
  const InventoryForm({super.key});

  @override
  ConsumerState<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends ConsumerState<InventoryForm> {
  final _formKey = GlobalKey<FormState>();
  var _selectedType = InventoryType.values.first;
  var _selectedUse = InventoryUse.values.first;
  Color _selectedColor = Colors.cyan;
  var _enteredName = "";
  var _enteredDescription = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Inventory')),
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
          style: textTheme.headlineLarge!.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Let's start filling up your \ninventory ",
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
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          InputField(
            label: "Inventory Name",
            initialValue: _enteredName,
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
            label: "Inventory Description",
            initialValue: _enteredDescription,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter a Description";
              }
              return null;
            },
            onSaved: (newValue) {
              _enteredDescription = newValue!.trim();
            },
          ),
          DropdownButtonFormField(
            initialValue: _selectedType,
            decoration: InputDecoration(labelText: "Type"),
            dropdownColor: colorScheme.primaryContainer,

            items: InventoryType.values
                .map((type) => buildDropdownItem(type, type.text))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          DropdownButtonFormField(
            initialValue: _selectedUse,
            decoration: InputDecoration(labelText: "Use"),
            dropdownColor: colorScheme.primaryContainer,

            items: InventoryUse.values
                .map((use) => buildDropdownItem(use, use.text))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedUse = value!;
              });
            },
          ),
          buildColorField(context),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 48),
            ),
            label: Text("Create Inventory"),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem buildDropdownItem(Enum value, String displayText) {
    return DropdownMenuItem(value: value, child: Text(displayText));
  }

  Widget buildColorField(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Text(
          "Color",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: showColorPickerWidget,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: _selectedColor,
            ),
          ),
        ),
      ],
    );
  }

  void showColorPickerWidget() {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(
            "Pick a color",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onSubmit() {
    final formState = _formKey.currentState!;
    if (!formState.validate()) {
      return;
    }

    formState.save();

    final newInventory = InventoryService.createNewInventory(
      name: _enteredName,
      description: _enteredDescription,
      type: _selectedType,
      use: _selectedUse,
      rColor: convertColorToInt(_selectedColor.r),
      gColor: convertColorToInt(_selectedColor.g),
      bColor: convertColorToInt(_selectedColor.b),
    );

    final inventoryNotifier = ref.read(inventoryProvider.notifier);
    inventoryNotifier.addInventory(newInventory);
  }

  int convertColorToInt(double value) {
    return (value * 255).round();
  }
}
