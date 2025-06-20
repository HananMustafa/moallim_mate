import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moallim_mate/utils/routes/routes_name.dart';
import 'package:moallim_mate/res/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;

      // Preload image
      precacheImage(const AssetImage('assets/icon/icon.png'), context).then((
        _,
      ) {
        // Delay navigation after preload completes
        Timer(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, RoutesName.dashboard);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(child: Image.asset('assets/icon/icon.png', width: 150)),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:moallim_mate/utils/routes/routes_name.dart';
// import 'package:moallim_mate/res/color.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Timer(const Duration(seconds: 1), () {
//       Navigator.pushNamed(context, RoutesName.dashboard);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: Center(
//         child: Image.asset(
//           'assets/icon/icon.png',
//           width: 150, // Adjust size as needed
//         ),
//       ),
//     );
//   }
// }
