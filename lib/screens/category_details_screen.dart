import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/screens/category_form_screen.dart';
import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen(this.category, {super.key});

  final Category category;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  late Category _category;
  @override
  void initState() {
    super.initState();
    _category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_category.name),
        actions: [
          IconButton(
            onPressed: () async {
              // obtaining the result of the update
              final result = await Navigator.of(context).push<Category>(
                MaterialPageRoute(
                  builder: (ctx) => CategoryFormScreen(isEditing: _category),
                ),
              );
              // seetting the result oft the update to the new value
              setState(() {
                _category = result!;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
        backgroundColor: Color.fromRGBO(
          _category.rValue,
          _category.gValue,
          _category.bValue,
          0.4,
        ),
      ),
      body: Text("Hello ${_category.name}"),
    );
  }
}
