import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';

class RadioRow extends StatelessWidget {
  const RadioRow({
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => onChanged(0),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg - 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selectedIndex == 0
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selectedIndex == 0
                      ? AppColors.primary
                      : AppColors.textMuted,
                  size: 22,
                ),
                const SizedBox(width: AppSizes.sm),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      leftText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: selectedIndex == 0
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: InkWell(
            onTap: () => onChanged(1),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg - 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selectedIndex == 1
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selectedIndex == 1
                      ? AppColors.primary
                      : AppColors.textMuted,
                  size: 22,
                ),
                const SizedBox(width: AppSizes.sm),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      rightText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: selectedIndex == 1
                            ? AppColors.primary
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
