import 'package:flutter/material.dart';

void main() {
  runApp(const BlkApp());
}

class BlkApp extends StatelessWidget {
  const BlkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ethircle BlkApp')),
        body: Center(child: Text('Hello, Ethircle BlkApp!')),
      ),
    );
  }
}
