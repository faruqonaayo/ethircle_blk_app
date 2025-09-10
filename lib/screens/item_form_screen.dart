import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/categories_provider.dart';
import 'package:ethircle_blk_app/widgets/image_field.dart';
import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/models/item.dart';
import 'package:ethircle_blk_app/providers/items_provider.dart';

class ItemFormScreen extends ConsumerStatefulWidget {
  const ItemFormScreen({super.key, this.isEditing});

  final Item? isEditing;
  @override
  ConsumerState<ItemFormScreen> createState() {
    return _ItemFormScreenState();
  }
}

class _ItemFormScreenState extends ConsumerState<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredDescription = "";
  var _enteredWorth = "";
  var _enteredAddress = "";
  Category? _selectedCategory;

  void _submitForm() {
    final formState = _formKey.currentState;

    if (!formState!.validate()) {
      return;
    }
    formState.save();
    final itemsNotifier = ref.read(itemsProvider.notifier);
    // logic to update data
    if (widget.isEditing != null) {
      final prevData = widget.isEditing!;
      final updatedItem = Item(
        id: prevData.id,
        name: _enteredName,
        description: _enteredDescription,
        worth: double.parse(_enteredWorth),
        address: _enteredAddress,
        imageUrl: "hello",
        catId: _selectedCategory!.id,
        isFavorite: prevData.isFavorite,
        createdAt: prevData.createdAt,
        updatedAt: DateTime.now(),
      );

      itemsNotifier.editItem(updatedItem);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Item '${prevData.name}' changed to  '${updatedItem.name}'",
          ),
        ),
      );
      // returns the new update as the screen is popped
      Navigator.of(context).pop(updatedItem);
      return;
    }

    // creating new item
    final newItem = Item.create(
      name: _enteredName,
      description: _enteredDescription,
      worth: double.parse(_enteredWorth),
      address: _enteredAddress,
      imageUrl: "hello",
      catId: _selectedCategory!.id,
    );

    itemsNotifier.addNewItem(newItem);
    formState.reset();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item '$_enteredName' saved successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final categories = ref.watch(categoriesProvider);
    final isEditing = widget.isEditing;

    if (isEditing != null) {
      setState(() {
        _selectedCategory = categories.firstWhere(
          (cat) => cat.id == isEditing.catId,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("New Item")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Start Adding New Item",
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: isEditing == null ? "" : isEditing.name,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredName = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: isEditing == null ? "" : isEditing.description,
                  decoration: InputDecoration(
                    label: Text("Description"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredDescription = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: isEditing == null
                      ? ""
                      : isEditing.worth.toString(),
                  decoration: InputDecoration(
                    label: Text("Worth"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a worth';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredWorth = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: isEditing == null ? "" : isEditing.address,
                  decoration: InputDecoration(
                    label: Text("Address"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a address';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredAddress = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                ImageField(),
                const SizedBox(height: 16),
                categories.isNotEmpty
                    ? DropdownMenuFormField(
                        initialSelection: isEditing != null
                            ? _selectedCategory
                            : null,
                        label: Text("Categories"),
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        width: double.infinity,
                        onSelected: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        dropdownMenuEntries: categories
                            .map(
                              (cat) => DropdownMenuEntry(
                                value: cat,
                                label: cat.name,
                              ),
                            )
                            .toList(),
                      )
                    : Text("No category"),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _submitForm,
            label: Text("Add Item"),
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
