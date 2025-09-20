import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _enteredFirstName = '';
  String _enteredLastName = '';
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredCPassword = '';

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      if (!_isLogin && _enteredCPassword != _enteredPassword) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords must match")));
        return;
      }

      try {
        final fbAuth = FirebaseAuth.instance;
        if (_isLogin) {
          await fbAuth.signInWithEmailAndPassword(
            email: _enteredEmail,
            password: _enteredPassword,
          );
        } else {
          await fbAuth.createUserWithEmailAndPassword(
            email: _enteredEmail,
            password: _enteredPassword,
          );
          FirebaseFirestore.instance.collection("users").add({
            "firstName": _enteredFirstName,
            "lastName": _enteredLastName,
            "email": _enteredEmail,
            "userUID": fbAuth.currentUser!.uid,
          });
        }

        if (!mounted) {
          return;
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.message ?? "Authentication failed",
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.surfaceContainerLow, colorScheme.surfaceDim],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inventory_outlined,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text("Ethircle BLK", style: theme.textTheme.titleSmall),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _isLogin ? "Welcome Back!" : "Start Keep Track Today!",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _isLogin
                      ? "Login to continue your journey"
                      : "Create an account to get started",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!_isLogin) ...[
                          _buildRoundedField(
                            key: const ValueKey("firstname"),
                            hint: "First Name",
                            icon: Icons.person,
                            validator: (v) => v == null || v.isEmpty
                                ? "Enter first name"
                                : null,
                            onSaved: (v) => _enteredFirstName = v!.trim(),
                          ),
                          const SizedBox(height: 16),
                          _buildRoundedField(
                            key: const ValueKey("lastname"),
                            hint: "Last Name",
                            icon: Icons.person_outline,
                            validator: (v) => v == null || v.isEmpty
                                ? "Enter last name"
                                : null,
                            onSaved: (v) => _enteredLastName = v!.trim(),
                          ),
                          const SizedBox(height: 16),
                        ],
                        _buildRoundedField(
                          key: const ValueKey("email"),
                          hint: "Email",
                          icon: Icons.email,
                          keyboard: TextInputType.emailAddress,
                          validator: (v) => v == null || !v.contains("@")
                              ? "Enter valid email"
                              : null,
                          onSaved: (v) => _enteredEmail = v!.trim(),
                        ),
                        const SizedBox(height: 16),
                        _buildRoundedField(
                          key: const ValueKey("password"),
                          hint: "Password",
                          icon: Icons.lock,
                          obscure: true,
                          validator: (v) => v == null || v.length < 6
                              ? "Min 6 characters"
                              : null,
                          onSaved: (v) => _enteredPassword = v!,
                        ),
                        const SizedBox(height: 16),
                        if (!_isLogin)
                          _buildRoundedField(
                            key: const ValueKey("cPassword"),
                            hint: "Confirm Password",
                            icon: Icons.lock_outline,
                            obscure: true,
                            validator: (v) => v == null || v.length < 6
                                ? "Min 6 characters"
                                : null,
                            onSaved: (v) => _enteredCPassword = v!,
                          ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 4),
                            onPressed: _submitForm,
                            child: Text(
                              _isLogin ? "Login" : "Sign Up",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => setState(() => _isLogin = !_isLogin),
                          child: Text(
                            _isLogin
                                ? "Don’t have an account? Sign Up"
                                : "Already have an account? Login",
                            style: TextStyle(
                              color: colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedField({
    required Key key,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      key: key,
      obscureText: obscure,
      keyboardType: keyboard,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        filled: true,
        fillColor: colorScheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
