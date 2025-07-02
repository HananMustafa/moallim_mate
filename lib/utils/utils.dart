import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:moallim_mate/res/color.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.black,
      textColor: AppColors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void flushbarErrorMessages(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: AppColors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(Icons.error, size: 28, color: AppColors.white),
      )..show(context),
    );
  }

  static void flushbarSuccessMessages(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: AppColors.green,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(Icons.error, size: 28, color: AppColors.white),
      )..show(context),
    );
  }
}
