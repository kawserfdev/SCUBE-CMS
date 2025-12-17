import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/widget/segmentchoice_widget.dart';

class SegmentedPill extends StatelessWidget {
  const SegmentedPill({
    required this.leftText,
    required this.rightText,
    required this.selectedIndex,
    required this.onChanged,
  });

  final String leftText;
  final String rightText;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: AppSizes.xxl),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SegmentChoice(
              selected: selectedIndex == 0,
              text: leftText,
              onTap: () => onChanged(0),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.textMuted,
            ),
          ),
          Expanded(
            child: SegmentChoice(
              selected: selectedIndex == 1,
              text: rightText,
              onTap: () => onChanged(1),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
