import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_assets.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/controller/screen_controller.dart';
import 'package:scubecms/features/sources/widget/infopair_widget.dart';

class RevenueInfoCard extends StatelessWidget {
  const RevenueInfoCard({
    required this.expanded,
    required this.onToggle,
    required this.rows,
    required this.percentBuilder,
  });

  final bool expanded;
  final VoidCallback onToggle;
  final List<RevenueRow> rows;
  final double Function(RevenueRow row) percentBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.sm),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: expanded
                ? BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSizes.sm),
                      bottom: Radius.circular(AppSizes.sm),
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.borderLightBlue,
                        width: 1.1,
                      ),
                    ),
                  )
                : null,
            child: Row(
              children: [
                Image.asset(AppAssets.vector, height: 18, width: 18),

                const SizedBox(width: AppSizes.md + 2),
                Text(
                  "Data & Cost Info",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDarkBlue,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      expanded
                          ? Icons.keyboard_double_arrow_up_rounded
                          : Icons.keyboard_double_arrow_down_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 180),
            crossFadeState: expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            secondChild: const SizedBox(height: AppSizes.xs),
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),
              child: Column(
                children: List.generate(rows.length, (i) {
                  final r = rows[i];
                  final idx = i + 1;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: i == rows.length - 1 ? 0 : 8,
                    ),
                    child: InfoPair(
                      dataLabel: "Data $idx",
                      dataValue:
                          "${r.data.toStringAsFixed(2)} (${percentBuilder(r).toStringAsFixed(2)}%)",
                      costLabel: "Cost $idx",
                      costValue: "${r.cost} ৳",
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
