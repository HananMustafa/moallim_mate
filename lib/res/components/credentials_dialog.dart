import 'package:flutter/material.dart';
import 'package:moallim_mate/res/components/build_input_field.dart';
import 'package:moallim_mate/res/components/round_button.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:provider/provider.dart';

class CredentialsDialog extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onSave;

  const CredentialsDialog({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<ConnectMoellimViewModel>(context).loading;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 48.0,
              left: 16,
              right: 16,
              bottom: 24,
            ), // space for close icon
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Set New Credentials',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                BuildInputField(
                  label: 'Username',
                  controller: usernameController,
                ),
                const SizedBox(height: 16),
                BuildInputField(
                  label: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                RoundButton(title: 'Save', loading: isLoading, onPress: onSave),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
