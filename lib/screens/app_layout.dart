import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/screens/auth_screen.dart';
import 'package:ethircle_blk_app/widgets/loading.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  var _currentPage = 0;

  final _pages = [
    const Center(child: Text('Home Page')),
    null,
    const Center(child: Text('Inventory Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else if (snapshot.hasData) {
          return _buildAppLayout();
        } else {
          return AuthScreen();
        }
      },
    );
  }

  Widget _buildAppLayout() {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        backgroundColor: colorScheme.surfaceContainerHigh,
        items: _buildNavItems(),
        onTap: (value) {
          setState(() {
            if (value == 1) {
              // Handle the special case for the center button if needed
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return Center(child: Text('Add New Item'));
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
