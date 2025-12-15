import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../controller/screen_controller.dart';

class ScreenOne extends GetView<ScreenController> {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
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
                      // Top segmented: Data View / Revenue View
                      Obx(
                        () => _SegmentedPill(
                          leftText: "Data View",
                          rightText: "Revenue View",
                          selectedIndex: controller.topSegment.value,
                          onChanged: (i) => controller.topSegment.value = i,
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Gauge
                      Obx(
                        () => _SemiGauge(
                          valueText: controller.gaugeValue.value
                              .toStringAsFixed(2),
                          unitText: "kWh/Sqft",
                          progress: _mapGaugeToProgress(
                            controller.gaugeValue.value,
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSizes.fontSizeXl),

                      // Date radios: Today / Custom
                      Obx(
                        () => _RadioRow(
                          leftText: "Today Data",
                          rightText: "Custom Date Data",
                          selectedIndex: controller.dateMode.value,
                          onChanged: (i) => controller.dateMode.value = i,
                        ),
                      ),

                      const SizedBox(height: AppSizes.fontSizeXl),

                      // Energy Chart Card
                      Obx(
                        () => _EnergyChartCard(
                          totalKw: controller.totalKw.value,
                          items: controller.items,
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

  // you can change scaling later; this is only for UI arc amount
  double _mapGaugeToProgress(double v) {
    // clamp 0..100 to 0..1
    final x = v.clamp(0, 100);
    return x / 100.0;
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
                  width: 10, // Dot size
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

/// -------------------- SEGMENTED PILL (TOP) --------------------

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
              activeColor: AppColors.activeBlue,
              inactiveColor: AppColors.textMuted,
            ),
          ),
          Expanded(
            child: _SegmentChoice(
              selected: selectedIndex == 1,
              text: rightText,
              onTap: () => onChanged(1),
              activeColor: AppColors.activeBlue,
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

/// -------------------- SEMI GAUGE --------------------

class _SemiGauge extends StatelessWidget {
  const _SemiGauge({
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
      height: 260,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          height: 260,
          width:
              260, // Ensure strictly defined width for the scaleDown to work against
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(260, 170),
                painter: _SemiGaugePainter(
                  progress: progress.clamp(0, 1),
                  trackColor: AppColors.gaugeTrack,
                  valueColor: AppColors.gaugeBlue,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    valueText,
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDarkBlue,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs + 2),
                  Text(
                    unitText,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
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
  });

  final double progress;
  final Color trackColor;
  final Color valueColor;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 24.0;
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

    // Semi: from 180deg (pi) to 0deg (0) => sweep pi
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
        oldDelegate.valueColor != valueColor;
  }
}

/// -------------------- RADIO ROW (TODAY / CUSTOM) --------------------

class _RadioRow extends StatelessWidget {
  const _RadioRow({
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
                      ? AppColors.activeBlue
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
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: selectedIndex == 0
                            ? AppColors.activeBlue
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
                      ? AppColors.activeBlue
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
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: selectedIndex == 1
                            ? AppColors.activeBlue
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

/// -------------------- ENERGY CARD --------------------

class _EnergyChartCard extends StatelessWidget {
  const _EnergyChartCard({required this.totalKw, required this.items});

  final double totalKw;
  final List<EnergyRowModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.lg),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Energy Chart",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDarkBlue,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${totalKw.toStringAsFixed(2)} kw",
                    style: const TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDarkBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.fontSizeXl),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.md),
              child: _EnergyRow(item: e),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnergyRow extends StatelessWidget {
  const _EnergyRow({required this.item});

  final EnergyRowModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Row(
        children: [
          // Left label section (Data A/B/C/D)
          SizedBox(
            width: 96,
            child: Row(
              children: [
                Container(
                  width: AppSizes.iconSm,
                  height: AppSizes.iconSm,
                  decoration: BoxDecoration(
                    color: Color(item.dotColor),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDarkBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Vertical divider
          Container(
            height: 54,
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
                      "Data",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${item.data.toStringAsFixed(2)} (${item.percent.toStringAsFixed(2)}%)",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textDarkBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      "Cost",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${item.cost} ৳",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: AppColors.textDarkBlue,
                          ),
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
