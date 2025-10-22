import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/widgets/add_options.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  var _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ethircle BlkApp')),
      body: Center(child: Text('Hello, Ethircle BlkApp!')),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomBarItems,
        currentIndex: _currentPage,
        onTap: (value) {
          if (value == 1) {
            showModalBottomSheet(
              context: context,
              builder: (ctx) => AddOptions(),
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

  List<BottomNavigationBarItem> get bottomBarItems {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard_outlined),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(icon: addDataIcon, label: 'Add'),
      BottomNavigationBarItem(
        icon: Icon(Icons.inventory_outlined),
        label: 'Inventory',
      ),
    ];
  }

  Widget get addDataIcon {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 32,
      height: 32,

      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Icons.add, color: colorScheme.onPrimary),
    );
  }
}
