import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CategoryFormScreen extends StatefulWidget {
  const CategoryFormScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoryFormScreenState();
  }
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredDescription = "";
  Color _selectedColor = Colors.blue;

  void _submitForm() {
    final formState = _formKey.currentState;

    if (!formState!.validate()) {
      return;
    }
    formState.save();

    // ✅ Here you can send data to Firebase or state management
    print("Category Name: $_enteredName");
    print("Category Description: $_enteredDescription");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Category saved successfully!")));
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
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

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
