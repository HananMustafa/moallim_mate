import 'package:flutter/material.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/utils/routes/routes.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';
import 'package:moallim_mate/view_model/connect_moellim_view_model.dart';
import 'package:moallim_mate/view_model/event_view_model.dart';
import 'package:moallim_mate/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectMoellimViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => EventViewModel()),
      ],
      child: MaterialApp(
        title: 'Moallim Mate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            brightness: Brightness.light,
          ),
        ),
        // home: const Dashboard(title: 'Moallim Mate'),
        initialRoute: RoutesName.dashboard,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
