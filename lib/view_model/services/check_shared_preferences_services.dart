import 'package:flutter/material.dart';
import 'package:moallim_mate/res/components/dialog_box.dart';
import 'package:moallim_mate/view_model/services/credentials_dialog_helper.dart';
import 'package:moallim_mate/view_model/services/notification_services.dart';
import 'package:moallim_mate/view_model/user_view_model.dart';

class CheckSharedPreferences {
  static Future<void> checkTokenStatus(BuildContext context) async {
    UserViewModel userVM = UserViewModel();
    final user = await userVM.getUser();

    // Show dialog depending on token presence
    if (user.token == '' || user.token == 'null') {
      //GETTING DEVICE TOKEN
      String deviceToken = '';
      NotificationServices notificationServices = NotificationServices();
      notificationServices.getDeviceToken().then((value) {
        deviceToken = value;
      });
      // showDialog(
      //   context: context,
      //   builder: (context) => DialogBox(message: 'Connect Moellim first'),
      // );
      CredentialsDialogHelper.show(context, deviceToken);
    }
  }

  static Future<Map<String, String>> checkCredentialsStatus() async {
    UserViewModel userVM = UserViewModel();
    final user = await userVM.getUser();

    if (user.token == null || user.token == '' || user.token == 'null') {
      return {'username': 'Not available'};
    } else {
      return {
        'username': user.username ?? 'Not available',
        'password': user.password ?? '**',
      };
    }
  }
}
