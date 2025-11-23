import 'package:flutter/material.dart';

void main() {
  runApp(const BLKApp());
}

class BLKApp extends StatelessWidget {
  const BLKApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ethircle BLK App",
      home: Scaffold(body: Center(child: Text("Hello BLK App"))),
    );
  }
}
