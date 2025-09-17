import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ethircle_blk_app/screens/home_screen.dart';
import 'package:ethircle_blk_app/providers/shared_pref_provider.dart';
import 'package:ethircle_blk_app/providers/app_data_provider.dart';
import 'package:ethircle_blk_app/screens/favorite_screen.dart';
import 'package:ethircle_blk_app/screens/categories_screen.dart';
import 'package:ethircle_blk_app/widgets/add_options.dart';
import 'package:ethircle_blk_app/widgets/app_mode_button.dart';

class AppLayout extends ConsumerStatefulWidget {
  const AppLayout({super.key});

  @override
  ConsumerState<AppLayout> createState() {
    return _AppLayoutState();
  }
}

class _AppLayoutState extends ConsumerState<AppLayout> {
  late int _currentPage;
  late SharedPreferencesWithCache _sharedPreferencesWithCache;

  late Future<void> _loadAppData;

  final _pages = const [
    HomeScreen(),
    CategoriesScreen(),
    Text("Add Data"),
    FavoriteScreen(),
    Text("Profile"),
  ];

  @override
  void initState() {
    super.initState();
    final appData = ref.read(appDataProvider);
    _loadAppData = appData;
    _sharedPreferencesWithCache = ref.read(sharedPrefProvider);
    _currentPage = _sharedPreferencesWithCache.getInt("currentPage") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 187, 224, 255),
                ),
                child: Icon(Icons.person, size: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "BLK",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [AppModeButton()],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surfaceContainerLow, colorScheme.surfaceDim],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
          ),
        ),
        child: FutureBuilder(
          future: _loadAppData,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return _pages[_currentPage];
          },
        ),
      ),
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
        onTap: (value) async {
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

          _sharedPreferencesWithCache.setInt("currentPage", value);
          setState(() {
            _currentPage = value;
          });
        },
      ),
    );
  }
}
