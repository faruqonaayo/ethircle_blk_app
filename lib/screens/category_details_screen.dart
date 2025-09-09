import 'package:ethircle_blk_app/models/category.dart';
import 'package:ethircle_blk_app/screens/category_form_screen.dart';
import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => CategoryFormScreen()));
            },
            icon: Icon(Icons.edit),
          ),
        ],
        backgroundColor: Color.fromRGBO(
          category.rValue,
          category.gValue,
          category.bValue,
          0.4,
        ),
      ),
      body: Text("Hello ${category.name}"),
    );
  }
}
