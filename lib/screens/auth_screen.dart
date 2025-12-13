import 'package:ethircle_blk_app/theme.dart';
import 'package:ethircle_blk_app/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 96),
        children: [
          Text('Ethircle Blk', style: title1Style, textAlign: TextAlign.center),
          SizedBox(height: 8),
          Text(
            'Enter valid credentials to authenticate yourself',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 120),
          AuthForm(),
        ],
      ),
    );
  }
}
