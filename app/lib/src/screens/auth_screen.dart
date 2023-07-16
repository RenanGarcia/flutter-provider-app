import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:providertest/src/controllers/auth_controller.dart';

import '../components/auth_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AuthController>();
    final navigator = Navigator.of(context);

    controller.addListener(() {
      if (controller.state == AuthState.error) {
        const snack = SnackBar(content: Text('Erro na autenticação'));
        ScaffoldMessenger.of(context).showSnackBar(snack);
      } else if (controller.state == AuthState.success) {
        navigator.pushReplacementNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (value) {
                controller.authRequest =
                    controller.authRequest.copyWith(email: value);
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
              onChanged: (value) {
                controller.authRequest =
                    controller.authRequest.copyWith(password: value);
              },
            ),
            const SizedBox(height: 13),
            const AuthButton(),
          ],
        ),
      ),
    );
  }
}
