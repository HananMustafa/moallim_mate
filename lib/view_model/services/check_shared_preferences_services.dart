import 'package:flutter/material.dart';
import 'package:moallim_mate/res/components/dialog_box.dart';
import 'package:moallim_mate/view_model/user_view_model.dart';

class CheckSharedPreferences {
  static Future<void> checkTokenStatus(BuildContext context) async {
    UserViewModel userVM = UserViewModel();
    final user = await userVM.getUser();

    // Show dialog depending on token presence
    if (user.token == '' || user.token == 'null') {
      showDialog(
        context: context,
        builder: (context) => DialogBox(message: 'Connect Moellim first'),
      );
      // DialogBox(message: 'Connect Moellim first');
    } else {
      showDialog(
        context: context,
        builder: (context) => DialogBox(message: 'Moellim is Connected'),
      );
    }
  }

  static Future<Map<String, String>> checkCredentialsStatus() async {
    UserViewModel userVM = UserViewModel();
    final user = await userVM.getUser();

    if (user.token == null || user.token == '' || user.token == 'null') {
      return {'username': 'username not set', 'password': 'password not set'};
    } else {
      return {
        'username': user.username ?? 'username not set',
        'password': user.password ?? 'password not set',
      };
    }
  }
}
