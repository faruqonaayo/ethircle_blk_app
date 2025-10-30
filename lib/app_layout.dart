import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/data/providers/app_data_provider.dart';
import 'package:ethircle_blk_app/screens/inventory/inventory_list.dart';
import 'package:ethircle_blk_app/widgets/add_options.dart';

class AppLayout extends ConsumerStatefulWidget {
  const AppLayout({super.key});

  @override
  ConsumerState<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends ConsumerState<AppLayout> {
  late Future<void> _loadAppDataFuture;
  var _currentPage = 0;

  final pages = [
    Center(child: Text('Dashboard Page')),
    SizedBox.shrink(),
    InventoryList(),
  ];

  @override
  void initState() {
    super.initState();
    _loadAppDataFuture = ref.read(appDataProvider.notifier).loadAppData();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ethircle BlkApp', style: textTheme.titleSmall),
      ),
      body: FutureBuilder(
        future: _loadAppDataFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(child: Text('Error: ${asyncSnapshot.error}'));
          }
          return pages[_currentPage];
        },
      ),
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
