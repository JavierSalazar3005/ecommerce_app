import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: "cliente@correo.com");
  final _passwordController = TextEditingController(text: "123456");
  bool _loading = false;
  final _authService = AuthService();

  Future<void> _login() async {
    setState(() => _loading = true);
    final ok = await _authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
    setState(() => _loading = false);

    if (!mounted) return;
    if (ok) {
      Navigator.pushReplacementNamed(context, RouteNames.catalog);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Credenciales inválidas")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciar sesión")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Correo electrónico"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text("Ingresar"),
            ),
          ],
        ),
      ),
    );
  }
}
