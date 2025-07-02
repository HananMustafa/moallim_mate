import 'package:flutter/material.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/res/components/build_info_row.dart';
import 'package:moallim_mate/res/components/round_button.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
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
  String deviceToken = '';
  bool isPlaceholder = true;

  @override
  void initState() {
    super.initState();
    // loadUserCredentials();
    final viewModel = Provider.of<ConnectMoellimViewModel>(
      context,
      listen: false,
    );
    viewModel.loadUserCredentials();
    notificationServices.getDeviceToken().then((value) {
      deviceToken = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryBackground,
        elevation: 0,
        title: Text(
          'Connect Moellim',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2,
            color: AppColors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.white, // Set your desired color here
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ConnectMoellimViewModel>(
          builder: (context, model, child) {
            return Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildInfoRow(
                          title: 'Username',
                          value: model.username,
                          isPlaceholder: model.isPlaceholder,
                        ),
                        SizedBox(height: 16),
                        BuildInfoRow(
                          title: 'Password',
                          value: '********',
                          isPlaceholder: model.isPlaceholder,
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
            );
          },
        ),
      ),
    );
  }
}
