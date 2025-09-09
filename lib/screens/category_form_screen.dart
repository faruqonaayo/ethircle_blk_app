import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/categories_provider.dart';
import 'package:ethircle_blk_app/models/category.dart';

class CategoryFormScreen extends ConsumerStatefulWidget {
  const CategoryFormScreen({super.key, this.isEditing});

  final Category? isEditing;

  @override
  ConsumerState<CategoryFormScreen> createState() {
    return _CategoryFormScreenState();
  }
}

class _CategoryFormScreenState extends ConsumerState<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredDescription = "";
  late Color _selectedColor;

  void _submitForm() {
    final formState = _formKey.currentState;

    if (!formState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Complete all fields",
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    formState.save();
    final categoriesNotifier = ref.read(categoriesProvider.notifier);

    // logic for updating a new category
    if (widget.isEditing != null) {
      final prevData = widget.isEditing!;
      final updatedCat = Category(
        id: prevData.id,
        name: _enteredName,
        description: _enteredDescription,
        aValue: double.parse(_selectedColor.a.toStringAsFixed(2)),
        rValue: (_selectedColor.r * 255).toInt(),
        gValue: (_selectedColor.g * 255).toInt(),
        bValue: (_selectedColor.b * 255).toInt(),
      );
      categoriesNotifier.editCategory(updatedCat);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Category '${prevData.name}' changed to  '${updatedCat.name}'",
          ),
        ),
      );
      // returns the new update as the screen is popped
      Navigator.of(context).pop(updatedCat);
      return;
    }

    // creating new category object
    final newCategory = Category.create(
      name: _enteredName,
      description: _enteredDescription,
      aValue: double.parse(_selectedColor.a.toStringAsFixed(2)),
      rValue: (_selectedColor.r * 255).toInt(),
      gValue: (_selectedColor.g * 255).toInt(),
      bValue: (_selectedColor.b * 255).toInt(),
    );

    categoriesNotifier.addNewCategory(newCategory);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Category '$_enteredName' saved successfully!")),
    );
  }

  void _chooseColor() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick a color'),
        content: ColorPicker(
          pickerColor: _selectedColor,
          onColorChanged: (color) {
            setState(() {
              _selectedColor = color;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final isEditing = widget.isEditing;

    _selectedColor = isEditing == null
        ? Colors.blue
        : Color.fromRGBO(
            isEditing.rValue,
            isEditing.gValue,
            isEditing.bValue,
            1,
          );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final isEditing = widget.isEditing;

    return Scaffold(
      appBar: AppBar(title: const Text("New Category")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Creating New Category",
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
                    label: const Text("Category Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a category name';
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
                    label: const Text("Category Description"),
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
                Row(
                  children: [
                    Text(
                      "Select Color: ",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _chooseColor,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _selectedColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _submitForm,
            label: const Text("Create Category"),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
