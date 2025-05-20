import 'package:flutter/material.dart';
import 'package:moallim_mate/res/color.dart';
import 'package:moallim_mate/utils/routes/routes.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
