import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _cPassword = '';

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // checking for pasword match
      if (!_isLogin && _cPassword != _password) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password must match",
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        print("hey");
        return;
      }

      // Handle authentication logic here
      try {
        final fbAuth = FirebaseAuth.instance;

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isLogin ? 'Logging in...' : 'Signing up...')),
        );
        if (_isLogin) {
          fbAuth.signInWithEmailAndPassword(email: _email, password: _password);
        } else {
          await fbAuth.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
        }
        if (!mounted) {
          return;
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message ?? "An error has occured",
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: 64, color: Colors.blueGrey),
                    const SizedBox(height: 16),
                    Text(
                      _isLogin ? 'Welcome Back' : 'Create Account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      key: const ValueKey('email'),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!.trim(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const ValueKey('password'),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),
                    const SizedBox(height: 16),
                    _isLogin
                        ? SizedBox.shrink()
                        : TextFormField(
                            key: const ValueKey('cPassword'),
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) => _cPassword = value!,
                          ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(_isLogin ? 'Login' : 'Sign Up'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? 'Don\'t have an account? Sign Up'
                            : 'Already have an account? Login',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
