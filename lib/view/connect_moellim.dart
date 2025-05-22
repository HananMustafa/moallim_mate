import 'package:flutter/material.dart';
import 'package:moallim_mate/res/components/build_info_row.dart';
import 'package:moallim_mate/res/components/credentials_dialog.dart';
import 'package:moallim_mate/res/components/round_button.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:provider/provider.dart';

class ConnectMoellim extends StatefulWidget {
  const ConnectMoellim({super.key});

  @override
  State<ConnectMoellim> createState() => _ConnectMoellimState();
}

class _ConnectMoellimState extends State<ConnectMoellim> {
  @override
  Widget build(BuildContext context) {
    final connectMoellimViewModel = Provider.of<ConnectMoellimViewModel>(
      context,
    );

    void _showCredentialDialog(BuildContext context) {
      final usernameController = TextEditingController();
      final passwordController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return CredentialsDialog(
            usernameController: usernameController,
            passwordController: passwordController,
            onSave: () {
              print('USERNAME: ${usernameController.text.toString()}');
              print('PASSWORD: ${passwordController.text.toString()}');
              Map data = {
                'username': usernameController.text.toString(),
                'password': passwordController.text.toString(),
              };

              final connectMoellimViewModel =
                  Provider.of<ConnectMoellimViewModel>(context, listen: false);
              connectMoellimViewModel.ConnectMoellimApi(data, context);
              // print('Api hit');
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Connect Moellim'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity, // full width of parent
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildInfoRow(title: 'Username', value: 'xyz'),
                    SizedBox(height: 16),
                    BuildInfoRow(title: 'Password', value: '******'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            RoundButton(
              title: 'Update',
              onPress: () {
                _showCredentialDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
