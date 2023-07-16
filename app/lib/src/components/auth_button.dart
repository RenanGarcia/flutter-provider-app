import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();

    void handler() => controller.loginAction(context);
    final isLoading = controller.state == AuthState.loading;

    return ElevatedButton(
      onPressed: isLoading ? null : handler,
      child: const Text('Login'),
    );
  }
}
