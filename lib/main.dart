import 'package:flutter/material.dart';

void main() {
  runApp(const BlkApp());
}

class BlkApp extends StatelessWidget {
  const BlkApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blk App',
      home: Scaffold(body: Center(child: Text('Hello, Blk App!'))),
    );
  }
}
