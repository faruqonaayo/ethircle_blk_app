import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/widgets/image_field.dart';

class ItemFormScreen extends StatefulWidget {
  const ItemFormScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ItemFormScreenState();
  }
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = "";
  var _enteredDescription = "";
  var _enteredWorth = "";
  var _enteredAddress = "";

  void _submitForm() {
    final formState = _formKey.currentState;

    if (!formState!.validate()) {
      return;
    }
    formState.save();
    print("valid");
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

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
                  decoration: InputDecoration(
                    label: Text("Description"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
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
