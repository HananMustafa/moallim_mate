import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/res/components/round_button.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';
import 'package:moallim_mate/utils/utils.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:moallim_mate/view_model/event_view_model.dart';
import 'package:moallim_mate/view_model/services/check_shared_preferences_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});

  final String title;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Call DashboardServices to check token
    CheckSharedPreferences.checkTokenStatus(context);
  }

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
        child: Column(
          children: [
            RoundButton(
              title: 'Get Events',
              loading:
                  Provider.of<ConnectMoellimViewModel>(context).getEventLoading,
              onPress: () async {
                // Getting Token
                print('ACTION: GETTING TOKEN');
                SharedPreferences sp = await SharedPreferences.getInstance();
                String? token = sp.getString('token');
                Map data = {'token': token};

                // Hitting Get Events Api
                print('ACTION: HITTING GET EVENTS API');
                final connectMoellimViewModel =
                    Provider.of<ConnectMoellimViewModel>(
                      context,
                      listen: false,
                    );
                await connectMoellimViewModel.GetEventsApi(data, context);

                // Getting Events Data from Shared Preferences
                print('ACTION: EXTRACTING EVENTS FROM SP');
                final eventViewModel = Provider.of<EventViewModel>(
                  context,
                  listen: false,
                );
                final event = await eventViewModel.getEvent();
                if (event != null) {
                  print(
                    'Events extracted from shared preferences: ${event.toJson()}',
                  );
                } else {
                  print('No event found in shared preferences');
                }
              },
            ),
          ],
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
