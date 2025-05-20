import 'package:flutter/material.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';
import 'package:moallim_mate/view/connect_moellim.dart';
import 'package:moallim_mate/view/dashboard.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.dashboard:
        return MaterialPageRoute(
          builder: (BuildContext context) => Dashboard(title: 'Moallim Mate'),
        );

      case RoutesName.connectMoellim:
        return MaterialPageRoute(
          builder: (BuildContext context) => ConnectMoellim(),
        );

      //Add more cases

      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(body: Center(child: Text('No route defined')));
          },
        );
    }
  }
}
