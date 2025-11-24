import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/theme.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  var currentPage = 0;

  final pages = [
    Center(child: Text("Home Page", style: title1)),
    null,
    Center(child: Text("Categories Page", style: title1)),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("BLK App", style: textTheme.bodySmall),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
      ),
      body: pages[currentPage],
      bottomNavigationBar: botNavBar,
    );
  }

  // This function returns the bottom navigation bar
  BottomNavigationBar get botNavBar {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(currentPage == 0 ? Icons.home : Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentPage == 2 ? Icons.category : Icons.category_outlined,
          ),
          label: "Categories",
        ),
      ],
      currentIndex: currentPage,
      onTap: (value) {
        if (value == 1) {
          showModalBottomSheet(context: context, builder: (ctx) => Container());
          return;
        }
        setState(() {
          currentPage = value;
        });
      },
    );
  }
}
