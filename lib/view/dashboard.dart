import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/res/components/round_button.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final connectMoellimViewModel = Provider.of<ConnectMoellimViewModel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: RoundButton(
          title: 'Get Events',
          loading:
              Provider.of<ConnectMoellimViewModel>(context).getEventLoading,
          onPress: () {
            Map data = {'token': 'acdbc014b732ff3958862cd269a5c612'};

            final connectMoellimViewModel =
                Provider.of<ConnectMoellimViewModel>(context, listen: false);

            connectMoellimViewModel.GetEventsApi(data, context);
          },
        ),
      ),

      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: AppColors.primary,
        children: [
          SpeedDialChild(
            child: Icon(Icons.sync),
            label: 'Connect Moellim',
            onTap: () {
              Navigator.pushNamed(context, RoutesName.connectMoellim);
            },
          ),
        ],
      ),
    );
  }
}
