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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              Map data = {
                'username': _usernameController.text.toString(),
                'password': _passwordController.text.toString(),
              };

              ConnectMoellimViewModel X = new ConnectMoellimViewModel();

              X.ConnectMoellimApi(data, context);
              // Call ViewModel function here to handle logic
              // viewModel.updateCredentials(usernameController.text, passwordController.text);
              // Navigator.of(context).pop();
              print('Api hit');
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
