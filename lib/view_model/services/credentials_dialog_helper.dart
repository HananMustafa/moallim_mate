import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moallim_mate/res/components/credentials_dialog.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';

class CredentialsDialogHelper {
  static void show(BuildContext context, String deviceToken) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return CredentialsDialog(
          usernameController: usernameController,
          passwordController: passwordController,
          onSave: () async {
            Map data = {
              'username': usernameController.text.toString(),
              'password': passwordController.text.toString(),
              'deviceToken': deviceToken,
            };

            final connectMoellimViewModel =
                Provider.of<ConnectMoellimViewModel>(context, listen: false);
            await connectMoellimViewModel.connectMoellimApi(data, context);
          },
        );
      },
    );
  }
}
