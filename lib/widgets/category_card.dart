import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/models/category.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        splashColor: Color.fromRGBO(
          category.rValue,
          category.gValue,
          category.bValue,
          0.32,
        ),
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(
                  category.rValue,
                  category.gValue,
                  category.bValue,
                  0.16,
                ),
                Color.fromRGBO(
                  category.rValue,
                  category.gValue,
                  category.bValue,
                  0.07,
                ),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Text(
                category.name,
                style: textTheme.bodyLarge!.copyWith(
                  color: Color.fromRGBO(
                    category.rValue,
                    category.gValue,
                    category.bValue,
                    1,
                  ),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.chevron_right,
                size: 32,
                color: Color.fromRGBO(
                  category.rValue,
                  category.gValue,
                  category.bValue,
                  1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
