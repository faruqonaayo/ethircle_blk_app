import 'package:ethircle_blk_app/providers/inventory_provider.dart';
import 'package:ethircle_blk_app/providers/item_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ethircle_blk_app/providers/app_data_provider.dart';
import 'package:ethircle_blk_app/widgets/loading.dart';
import 'package:ethircle_blk_app/screens/inventory_list_screen.dart';
import 'package:ethircle_blk_app/widgets/add_options.dart';

class AppLayout extends ConsumerStatefulWidget {
  const AppLayout({super.key});

  @override
  ConsumerState<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends ConsumerState<AppLayout> {
  late Future<void> _loadAppData;
  var _currentPage = 0;

  final _pages = [
    const Center(child: Text('Home Page')),
    null,
    const InventoryListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      _loadAppData = ref.read(appDataProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildAppLayout();
  }

  Widget _buildAppLayout() {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();

              // invalidating providers in order to reset app wide state
              ref.invalidate(inventoryProvider);
              ref.invalidate(appDataProvider);
              ref.invalidate(itemProvider);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadAppData,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return _pages[_currentPage]!;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        backgroundColor: colorScheme.surfaceContainerHigh,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        items: _buildNavItems(),
        onTap: (value) {
          setState(() {
            if (value == 1) {
              // Handle the special case for the center button if needed
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return AddOptions();
                },
              );

              return;
            }
            _currentPage = value;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        label: '',
      ),
      BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Inventory'),
    ];
  }
}
