import 'package:flutter/material.dart';

import 'package:ethircle_blk_app/services/user_services.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange(this.parentCtx, {super.key});

  final BuildContext parentCtx;

  @override
  State<StatefulWidget> createState() {
    return _PasswordChangeState();
  }
}

class _PasswordChangeState extends State<PasswordChange> {
  final _formKey = GlobalKey<FormState>();
  String _enteredPassword = "";
  String _enteredCPassword = "";
  String? _errorMessage;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_enteredCPassword != _enteredPassword) {
        setState(() {
          _errorMessage = "Password must match";
        });
        return;
      }

      // Handle password change logic here
      final response = await UserServices.updatePassword(_enteredPassword);

      if (!mounted) {
        return;
      }

      if (response != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully!')),
        );
        Navigator.of(widget.parentCtx).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _errorMessage == null
                ? SizedBox.shrink()
                : Text(_errorMessage!, style: TextStyle(color: Colors.red)),

            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              onSaved: (value) {
                _enteredPassword = value ?? "";
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }

                return null;
              },
              onSaved: (value) {
                _enteredCPassword = value ?? "";
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.save),
                label: const Text('Change'),
                style: ElevatedButton.styleFrom(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
