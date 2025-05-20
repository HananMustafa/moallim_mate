import 'package:flutter/material.dart';
import 'package:moallim_mate/dashboard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moallim Mate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFFF7518),
          brightness: Brightness.light,
        ),
      ),
      home: const Dashboard(title: 'Moallim Mate'),
    );
  }
}
