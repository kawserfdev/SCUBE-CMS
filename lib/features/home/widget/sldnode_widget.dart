import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';

class SldNode extends StatelessWidget {
  const SldNode({required this.icon, required this.label});
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.tileBackground,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 2),
          ),
          child: Image.asset(icon, height: 24,width: 24,),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.fontSizeSm,
            color: AppColors.textDarkBlue,
          ),
        ),
      ],
    );
  }
}
