import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/controller/screen_controller.dart';

class EnergyRow extends StatelessWidget {
  const EnergyRow({required this.item});

  final EnergyRowModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Row(
        children: [
          // Left label section (Data A/B/C/D)
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: AppSizes.sm,
                  height: AppSizes.sm,
                  decoration: BoxDecoration(
                    color: Color(item.dotColor),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: AppSizes.xs),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDarkBlue,
                  ),
                ),
              ],
            ),
          ),

          // Vertical divider
          // VerticalDivider(
          //   thickness: 1,
          //   color: AppColors.border,
          // ),
          Container(
            height: 24,
            width: 1.2,
            color: AppColors.borderLightBlue,
            margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          ),

          // Right values
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Data : ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textMuted,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${item.data.toStringAsFixed(2)} (${item.percent.toStringAsFixed(2)}%)",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDarkBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Cost : ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textMuted,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${item.cost} ৳",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDarkBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
