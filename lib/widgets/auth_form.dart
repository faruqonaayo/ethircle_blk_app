import 'package:firebase_auth/firebase_auth.dart';
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
  var _enteredEmail = '';
  var _enteredFirstName = '';
  var _enteredLastName = '';
  var _enteredPassword = '';
  var _enteredPasswordConfirm = '';

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    // checking if passwords match in sign up mode
    if (!_isLogin && (_enteredPassword != _enteredPasswordConfirm)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Passwords do not match.',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final auth = FirebaseAuth.instance;
    // logic for user that is signing up for the first time
    if (!_isLogin) {
      await auth.createUserWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
    } else {
      // logic for existing user logging in
      await auth.signInWithEmailAndPassword(
        email: _enteredEmail,
        password: _enteredPassword,
      );
    }
  }

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
            validatorFn: (value) {
              if (value == null || !value.contains('@')) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
            saveFn: (value) {
              _enteredEmail = value!;
            },
          ),
          if (!_isLogin)
            InputField(
              labelText: "First Name",
              hintText: "Enter your first name",
              validatorFn: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name.';
                }
                return null;
              },
              saveFn: (value) {
                _enteredFirstName = value!;
              },
            ),
          if (!_isLogin)
            InputField(
              labelText: "Last Name",
              hintText: "Enter your last name",
              validatorFn: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name.';
                }
                return null;
              },
              saveFn: (value) {
                _enteredLastName = value!;
              },
            ),
          InputField(
            labelText: "Password",
            hintText: "Enter your password",
            obscureText: true,
            validatorFn: (value) {
              if (value == null || value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }
              return null;
            },
            saveFn: (value) {
              _enteredPassword = value!;
            },
          ),
          if (!_isLogin)
            InputField(
              labelText: "Confirm Password",
              hintText: "Re-enter your password",
              obscureText: true,
              validatorFn: (value) {
                if (value == null || value.length < 6) {
                  return 'Password must be at least 6 characters long.';
                }
                return null;
              },
              saveFn: (value) {
                _enteredPasswordConfirm = value!;
              },
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
