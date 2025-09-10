import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/screens/favorite_screen.dart';
import 'package:ethircle_blk_app/screens/categories_screen.dart';
import 'package:ethircle_blk_app/widgets/add_options.dart';
import 'package:ethircle_blk_app/widgets/app_mode_button.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppLayoutState();
  }
}

class _AppLayoutState extends State<AppLayout> {
  var _currentPage = 0;

  final _pages = const [
    Text("Home"),
    CategoriesScreen(),
    Text("Add Data"),
    FavoriteScreen(),
    Text("Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(actions: [AppModeButton()]),
      body: IndexedStack(index: _currentPage, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: colorScheme.surfaceContainerLow,
        unselectedItemColor: colorScheme.secondary,
        selectedItemColor: colorScheme.primary,
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.add, color: colorScheme.onPrimary),
            ),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        onTap: (value) {
          // Tapping on the add icon in the navigation bar acts differently by displaying a modal bottom sheet with options
          if (value == 2) {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => const SizedBox(
                height: 160,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AddOptions(),
                ),
              ),
            );
            return;
          }
          setState(() {
            _currentPage = value;
          });
        },
      ),
    );
  }
}
