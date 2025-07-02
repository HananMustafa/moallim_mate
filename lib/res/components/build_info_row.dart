import 'package:flutter/material.dart';
import 'package:moallim_mate/res/color.dart';

class BuildInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isPlaceholder;

  const BuildInfoRow({
    super.key,
    required this.title,
    required this.value,
    required this.isPlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.grey700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isPlaceholder ? AppColors.grey : AppColors.black,
            fontStyle: isPlaceholder ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ],
    );
  }
}
