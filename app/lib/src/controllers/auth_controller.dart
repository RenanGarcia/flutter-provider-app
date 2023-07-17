import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:providertest/src/services/client_http.dart';
import 'package:providertest/src/models/auth_request_model.dart';
import 'package:providertest/src/models/user_model.dart';

enum AuthState { idle, success, error, loading }

class AuthController extends ChangeNotifier {
  var authRequest = AuthRequestModel('', '');

  var state = AuthState.idle;

  final ClientHttp api;

  AuthController(this.api);

  Future<void> loginAction(BuildContext context) async {
    state = AuthState.loading;
    notifyListeners();
    // await Future.delayed(const Duration(seconds: 2));
    try {
      const url = 'http://localhost:8080/auth';
      final response = await api.post(url, data: authRequest.toMap());
      final shared = await SharedPreferences.getInstance();
      globalUserModel = UserModel.fromMap(response);
      await shared.setString('UserModel', globalUserModel!.toJson());
      state = AuthState.success;
      notifyListeners();
    } catch (e) {
      state = AuthState.error;
      notifyListeners();
    }
  }
}
