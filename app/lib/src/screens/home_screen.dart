import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final shared = await SharedPreferences.getInstance();
            shared.remove('UserModel');
            if (context.mounted) {
              Navigator.of(context).pushReplacementNamed('/auth');
            }
          },
          child: const Text('Signout'),
        ),
      ),
    );
  }
}
