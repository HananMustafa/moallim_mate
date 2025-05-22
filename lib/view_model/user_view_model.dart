import 'package:flutter/material.dart';
import 'package:moallim_mate/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    sp.setString('username', user.username.toString());
    sp.setString('password', user.password.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    final String? username = sp.getString('username');
    final String? password = sp.getString('password');
    return UserModel(
      token: token.toString(),
      username: username.toString(),
      password: password.toString(),
    );
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    sp.remove('username');
    sp.remove('password');
    return true;
  }
}
