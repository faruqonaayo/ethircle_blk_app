import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:ethircle_blk_app/screens/inventory_form_screen.dart';
import 'package:ethircle_blk_app/screens/app_layout.dart';
import 'package:ethircle_blk_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(BlkApp());
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
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Blk App',
      themeMode: ThemeMode.dark,
      theme: getThemeData(kColorScheme),
      darkTheme: getThemeData(kDarkColorScheme),
      routerConfig: _router,
    );
  }
}
