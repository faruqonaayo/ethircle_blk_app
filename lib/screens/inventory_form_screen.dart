import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/models/inventory_use.dart';
import 'package:ethircle_blk_app/theme.dart';
import 'package:ethircle_blk_app/widgets/input_field.dart';

class InventoryFormScreen extends StatefulWidget {
  const InventoryFormScreen({super.key});

  @override
  State<InventoryFormScreen> createState() => _InventoryFormScreenState();
}

class _InventoryFormScreenState extends State<InventoryFormScreen> {
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
            child: Column(
              spacing: 16,
              children: [
                InputField(
                  labelText: "Name",
                  hintText: "Enter inventory name",
                  validatorFn: (value) {},
                  saveFn: (value) {},
                ),
                InputField(
                  labelText: "Description",
                  hintText: "Enter inventory description",
                  validatorFn: (value) {},
                  saveFn: (value) {},
                  maxLines: 4,
                ),
                DropdownButtonFormField(
                  initialValue: InventoryUse.values.first,
                  items: _buildDropdownItems(),
                  onChanged: (value) {},
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
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
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
        .map((use) => DropdownMenuItem(value: use, child: Text(use.name)))
        .toList();
  }
}
