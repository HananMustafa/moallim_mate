// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:moallim_mate/utils/routes/routes_name.dart';
// import 'package:moallim_mate/res/color.dart';
// import 'package:package_info_plus/package_info_plus.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   bool _initialized = false;
//   String _appVersion = '';

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     if (!_initialized) {
//       _initialized = true;

//       // Preload image
//       precacheImage(const AssetImage('assets/icon/icon.png'), context).then((
//         _,
//       ) {
//         // Fetch app version
//         _loadVersionInfo();

//         // Delay navigation after preload completes
//         Timer(const Duration(seconds: 1), () {
//           Navigator.pushNamed(context, RoutesName.dashboard);
//         });
//       });
//     }
//   }

//   Future<void> _loadVersionInfo() async {
//     final info = await PackageInfo.fromPlatform();
//     setState(() {
//       _appVersion = 'Version ${info.version}';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(), // Push content to center
//             Center(child: Image.asset('assets/icon/icon.png', width: 150)),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: Text(
//                 _appVersion,
//                 style: const TextStyle(
//                   color: AppColors.white70,
//                   fontSize: 12,
//                   fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
