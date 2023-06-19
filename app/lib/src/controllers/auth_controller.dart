import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_request_model.dart';
import '../models/user_model.dart';

enum AuthState { idle, success, error, loading }

class AuthController extends ChangeNotifier {
  var authRequest = AuthRequestModel('', '');

  var state = AuthState.idle;

  Future<void> loginAction(BuildContext context) async {
    state = AuthState.loading;
    await Future.delayed(const Duration(seconds: 2));
    try {
      const url = 'http://localhost:8080/auth';
      final response = await Dio().post(url, data: authRequest.toMap());
      final shared = await SharedPreferences.getInstance();
      globalUserModel = UserModel.fromMap(jsonDecode(response.data));
      await shared.setString('UserModel', globalUserModel!.toJson());
      state = AuthState.success;
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }
}
