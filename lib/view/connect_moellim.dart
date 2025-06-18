import 'package:flutter/material.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/res/components/build_info_row.dart';
import 'package:moallim_mate/res/components/credentials_dialog.dart';
import 'package:moallim_mate/res/components/round_button.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:moallim_mate/view_model/services/check_shared_preferences_services.dart';
import 'package:moallim_mate/view_model/services/credentials_dialog_helper.dart';
import 'package:moallim_mate/view_model/services/notification_services.dart';
import 'package:provider/provider.dart';

class ConnectMoellim extends StatefulWidget {
  const ConnectMoellim({super.key});

  @override
  State<ConnectMoellim> createState() => _ConnectMoellimState();
}

class _ConnectMoellimState extends State<ConnectMoellim> {
  NotificationServices notificationServices = NotificationServices();
  String username = 'Not available';
  String password = '********';
  String deviceToken = '';
  bool isPlaceholder = true;

  @override
  void initState() {
    super.initState();
    loadUserCredentials();
    notificationServices.getDeviceToken().then((value) {
      deviceToken = value;
    });
  }

  // I AM REALLY SORRY FOR WRITING THIS CODE. PLEASE MODIFY IT, AND USE PROVIDER INSTEAD
  void loadUserCredentials() async {
    final credentials = await CheckSharedPreferences.checkCredentialsStatus();

    if (credentials['username'] != 'Not available') {
      setState(() {
        username = credentials['username']!;
        password = '********';
        isPlaceholder = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectMoellimViewModel = Provider.of<ConnectMoellimViewModel>(
      context,
    );

    // void _showCredentialDialog(BuildContext context) {
    //   final usernameController = TextEditingController();
    //   final passwordController = TextEditingController();

    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return CredentialsDialog(
    //         usernameController: usernameController,
    //         passwordController: passwordController,
    //         onSave: () async {
    //           print('USERNAME: ${usernameController.text.toString()}');
    //           print('PASSWORD: ${passwordController.text.toString()}');
    //           Map data = {
    //             'username': usernameController.text.toString(),
    //             'password': passwordController.text.toString(),
    //           };

    //           final connectMoellimViewModel =
    //               Provider.of<ConnectMoellimViewModel>(context, listen: false);
    //           await connectMoellimViewModel.ConnectMoellimApi(data, context);
    //           // print('Api hit');
    //           // Navigator.of(context).pop();
    //         },
    //       );
    //     },
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 136, 58),
        elevation: 0,
        title: Text(
          'Connect Moellim',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
            color: AppColors.whiteColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.whiteColor, // Set your desired color here
        ),
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
                    BuildInfoRow(
                      title: 'Username',
                      value: username,
                      isPlaceholder: isPlaceholder,
                    ),
                    SizedBox(height: 16),
                    BuildInfoRow(
                      title: 'Password',
                      value: password,
                      isPlaceholder: isPlaceholder,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),
            RoundButton(
              title: 'Update',
              onPress: () {
                CredentialsDialogHelper.show(context, deviceToken);
              },
            ),
          ],
        ),
      ),
    );
  }
}
