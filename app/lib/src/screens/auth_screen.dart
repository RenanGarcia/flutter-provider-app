import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_request_model.dart';
import '../models/user_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var authRequest = AuthRequestModel('', '');

  Future<void> loginAction(BuildContext context) async {
    try {
      const url = 'http://localhost:8080/auth';
      final response = await Dio().post(url, data: authRequest.toMap());
      final shared = await SharedPreferences.getInstance();
      globalUserModel = UserModel.fromMap(jsonDecode(response.data));
      await shared.setString('UserModel', globalUserModel!.toJson());
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      const msg = Text('Erro na autenticação');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: msg));
    }
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
                authRequest = authRequest.copyWith(email: value);
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
              onChanged: (value) {
                authRequest = authRequest.copyWith(password: value);
              },
            ),
            const SizedBox(height: 13),
            ElevatedButton(
              onPressed: () {
                loginAction(context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
