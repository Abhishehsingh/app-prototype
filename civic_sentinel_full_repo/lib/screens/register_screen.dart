import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;

  void _register() async {
    setState(() => _loading = true);
    try {
      await _auth.register(_emailCtl.text.trim(), _passCtl.text.trim());
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _emailCtl, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: _passCtl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _loading ? null : _register, child: _loading ? CircularProgressIndicator() : Text('Create account')),
        ]),
      ),
    );
  }
}