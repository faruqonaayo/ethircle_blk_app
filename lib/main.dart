import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:ethircle_blk_app/screens/inventory_screen.dart';
import 'package:ethircle_blk_app/screens/auth_screen.dart';
import 'package:ethircle_blk_app/screens/inventory_form_screen.dart';
import 'package:ethircle_blk_app/screens/app_layout.dart';
import 'package:ethircle_blk_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: BlkApp()));
}

class BlkApp extends StatelessWidget {
  BlkApp({super.key});

  // This widget is the root of your application.
  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (ctx, state) => AppLayout()),
      GoRoute(
        path: '/inventory/new',
        builder: (ctx, state) => InventoryFormScreen(),
      ),
      GoRoute(
        path: '/inventory/:id',
        builder: (ctx, state) {
          final inventoryId = state.pathParameters['id']!;
          return InventoryScreen(inventoryId);
        },
      ),
      GoRoute(
        path: "/inventory/edit/:id",
        builder: (ctx, state) {
          final inventoryId = state.pathParameters['id']!;
          return InventoryFormScreen(inventoryId: inventoryId);
        },
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp.router(
            title: 'Blk App',
            themeMode: ThemeMode.light,
            theme: getThemeData(kColorScheme),
            darkTheme: getThemeData(kDarkColorScheme),
            routerConfig: _router,
          );
        } else {
          return MaterialApp(
            title: 'Blk App',
            themeMode: ThemeMode.light,
            theme: getThemeData(kColorScheme),
            darkTheme: getThemeData(kDarkColorScheme),
            home: AuthScreen(),
          );
        }
      },
    );
  }
}
