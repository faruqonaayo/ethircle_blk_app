import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/widgets/input_field.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _password = '';

  void _trySubmit() {}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          InputField(
            labelText: "Email Address",
            hintText: "Enter your email address",
          ),
          if (!_isLogin)
            InputField(
              labelText: "First Name",
              hintText: "Enter your first name",
            ),
          if (!_isLogin)
            InputField(
              labelText: "Last Name",
              hintText: "Enter your last name",
            ),
          InputField(labelText: "Password", hintText: "Enter your password"),
          if (!_isLogin)
            InputField(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
            ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _trySubmit,
              child: Text(_isLogin ? 'Login' : 'Sign Up'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(
                _isLogin
                    ? 'Create a new account? Sign Up'
                    : 'I already have an account? Login',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
