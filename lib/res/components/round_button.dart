import 'package:flutter/material.dart';
import 'package:moallim_mate/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton({
    required this.title,
    this.loading = false,
    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child:
              loading
                  ? CircleAvatar()
                  : Text(title, style: TextStyle(color: AppColors.whiteColor)),
        ),
      ),
    );
  }
}

// Example of calling RoundButton in views
// RoundButton(
//   title: 'Give Title',
//   onPress: () {}
// )
