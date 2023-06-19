import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_request_model.dart';
import '../models/user_model.dart';

class AuthController {
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
}
