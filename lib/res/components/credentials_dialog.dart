import 'package:flutter/material.dart';
import 'package:moallim_mate/res/components/build_input_field.dart';
import 'package:moallim_mate/res/components/round_button.dart';

class CredentialsDialog extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onSave;

  const CredentialsDialog({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('Update Credentials'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildInputField(label: 'Username', controller: usernameController),
          SizedBox(height: 16),
          BuildInputField(
            label: 'Password',
            controller: passwordController,
            isPassword: true,
          ),
        ],
      ),
      actions: [RoundButton(title: 'Save', onPress: onSave)],
    );
  }
}
