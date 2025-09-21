import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtl = TextEditingController();
  final _passCtl = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;

  void _login() async {
    setState(() => _loading = true);
    try {
      await _auth.signIn(_emailCtl.text.trim(), _passCtl.text.trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Civic Sentinel — Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailCtl, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passCtl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _loading ? null : _login, child: _loading ? CircularProgressIndicator() : Text('Login')),
            TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen())), child: Text('Register'))
          ],
        ),
      ),
    );
  }
}