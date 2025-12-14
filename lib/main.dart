import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:ethircle_blk_app/screens/auth_screen.dart';
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
    initialLocation: '/auth',
    routes: [
      GoRoute(path: '/', builder: (ctx, state) => AppLayout()),
      GoRoute(path: '/auth', builder: (ctx, state) => AuthScreen()),
    ],
    redirect: (ctx, state) {
      if (state.uri.path == '/auth') {}
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Blk App',
      theme: getThemeData(kColorScheme),
      routerConfig: _router,
    );
  }
}
