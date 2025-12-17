import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/widget/custom_progress.dart';

class SemiGauge extends StatelessWidget {
  const SemiGauge({
    required this.valueText,
    required this.unitText,
    required this.progress,
  });

  final String valueText;
  final String unitText;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 140,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: const Size(180, 140),
            painter: SemiGaugePainter(
              progress: progress.clamp(0, 1),
              trackColor: AppColors.gaugeTrack,
              valueColor: AppColors.gaugeBlue,
            ),
          ),
          Positioned(
            bottom: - AppSizes.md,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  valueText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDarkBlue,
                  ),
                ),
                Text(
                  unitText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDarkBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
