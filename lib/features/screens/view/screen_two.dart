import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../controller/screen_controller.dart';

class ScreenTwo extends GetView<ScreenController> {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure Revenue View is selected (optional)
    // controller.topSegment.value = 1;

    return Scaffold(
      backgroundColor: AppColors.backgroundLightBlue,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(title: "SCM", onBack: () => Get.back(), onBell: () {}),
            const SizedBox(height: AppSizes.sm),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.md,
                  AppSizes.lg,
                  AppSizes.md,
                  AppSizes.md,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.92),
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                  border: Border.all(
                    color: AppColors.borderLightBlue,
                    width: 1.3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      blurRadius: AppSizes.lg,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // top segment (Data View / Revenue View)
                      Obx(
                        () => _SegmentedPill(
                          leftText: "Data View",
                          rightText: "Revenue View",
                          selectedIndex: controller.topSegment.value,
                          onChanged: (i) => controller.topSegment.value = i,
                        ),
                      ),

                      const SizedBox(height: AppSizes.xxl),

                      // revenue gauge
                      Obx(
                        () => _RevenueGauge(
                          value: controller.revenueValue.value,
                          progress: 0.78, // arc amount like image
                        ),
                      ),

                      const SizedBox(height: AppSizes.xxl),

                      // Data & Cost Info card (collapsible)
                      Obx(
                        () => _RevenueInfoCard(
                          expanded: controller.revenueExpanded.value,
                          onToggle: () => controller.revenueExpanded.value =
                              !controller.revenueExpanded.value,
                          rows: controller.revenueRows,
                        ),
                      ),

                      const SizedBox(height: AppSizes.md),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.lg),
          ],
        ),
      ),
    );
  }
}

/// -------------------- TOP BAR --------------------

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.onBack,
    required this.onBell,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback onBell;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.textDarkBlue,
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.textDarkBlue,
            ),
          ),
          const Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: onBell,
                icon: const Icon(Icons.notifications_none_rounded),
                color: AppColors.textDarkBlue,
              ),
              Positioned(
                right: 12,
                top: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// -------------------- SEGMENTED PILL --------------------

class _SegmentedPill extends StatelessWidget {
  const _SegmentedPill({
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
      height: 62,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentChoice(
              selected: selectedIndex == 0,
              text: leftText,
              onTap: () => onChanged(0),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.textMuted,
            ),
          ),
          Expanded(
            child: _SegmentChoice(
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

class _SegmentChoice extends StatelessWidget {
  const _SegmentChoice({
    required this.selected,
    required this.text,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
  });

  final bool selected;
  final String text;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? activeColor : inactiveColor,
            size: 26,
          ),
          const SizedBox(width: AppSizes.sm),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: selected ? activeColor : inactiveColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------- REVENUE GAUGE --------------------

class _RevenueGauge extends StatelessWidget {
  const _RevenueGauge({required this.value, required this.progress});

  final double value;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          height: 280,
          width: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(300, 190),
                painter: _SemiGaugePainter(
                  progress: progress.clamp(0, 1),
                  trackColor: AppColors.gaugeTrack,
                  valueColor: AppColors.gaugeBlue,
                  stroke: 26,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDarkBlue,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  const Text(
                    "tk",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDarkBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SemiGaugePainter extends CustomPainter {
  _SemiGaugePainter({
    required this.progress,
    required this.trackColor,
    required this.valueColor,
    required this.stroke,
  });

  final double progress;
  final Color trackColor;
  final Color valueColor;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(0, 10) & Size(size.width, size.height);
    final center = Offset(rect.width / 2, rect.height);
    final radius = math.min(rect.width / 2, rect.height) - stroke;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final valuePaint = Paint()
      ..color = valueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final start = math.pi;
    final sweep = math.pi;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep,
      false,
      trackPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      sweep * progress,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SemiGaugePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.valueColor != valueColor ||
        oldDelegate.stroke != stroke;
  }
}

/// -------------------- INFO CARD --------------------

class _RevenueInfoCard extends StatelessWidget {
  const _RevenueInfoCard({
    required this.expanded,
    required this.onToggle,
    required this.rows,
  });

  final bool expanded;
  final VoidCallback onToggle;
  final List<RevenueRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.lg),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 74,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSizes.lg),
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.borderLightBlue,
                  width: 1.1,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bar_chart_rounded,
                  size: 30,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: AppSizes.md + 2),
                const Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Data & Cost Info",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textDarkBlue,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      expanded
                          ? Icons.keyboard_double_arrow_up_rounded
                          : Icons.keyboard_double_arrow_down_rounded,
                      color: Colors.white,
                      size: 30,
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
            secondChild: const SizedBox(height: AppSizes.md + 2),
            firstChild: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.fontSizeXl,
                AppSizes.fontSizeXl,
                AppSizes.fontSizeXl,
                AppSizes.fontSizeXl,
              ),
              child: Column(
                children: List.generate(rows.length, (i) {
                  final r = rows[i];
                  final idx = i + 1;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: i == rows.length - 1 ? 0 : 18,
                    ),
                    child: _InfoPair(
                      dataLabel: "Data $idx",
                      dataValue:
                          "${r.data.toStringAsFixed(2)} (${r.percent.toStringAsFixed(2)}%)",
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

class _InfoPair extends StatelessWidget {
  const _InfoPair({
    required this.dataLabel,
    required this.dataValue,
    required this.costLabel,
    required this.costValue,
  });

  final String dataLabel;
  final String dataValue;
  final String costLabel;
  final String costValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LineRow(label: dataLabel, value: dataValue),
        const SizedBox(height: AppSizes.sm + 2),
        _LineRow(label: costLabel, value: costValue),
      ],
    );
  }
}

class _LineRow extends StatelessWidget {
  const _LineRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 84,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ),
        const SizedBox(width: AppSizes.sm + 2),
        const Text(
          ":",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.textDarkBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
