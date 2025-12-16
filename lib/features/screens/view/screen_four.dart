import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../controller/screen_controller.dart';

class ScreenFour extends GetView<ScreenController> {
  const ScreenFour({super.key});

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
                  color: AppColors.white.withOpacity(.92),
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                  border: Border.all(
                    color: AppColors.borderLightBlue,
                    width: 1.3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(.06),
                      blurRadius: AppSizes.lg,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Top segment
                      Obx(
                        () => _SegmentedPill(
                          leftText: "Data View",
                          rightText: "Revenue View",
                          selectedIndex: controller.topSegment.value,
                          onChanged: (i) => controller.topSegment.value = i,
                        ),
                      ),
                      const SizedBox(height: AppSizes.xxl),

                      // Gauge 57.00 kWh/Sqft
                      Obx(
                        () => _SemiGauge(
                          valueText: controller.dataGaugeValue.value
                              .toStringAsFixed(2),
                          unitText: "kWh/Sqft",
                          progress:
                              (controller.dataGaugeValue.value.clamp(0, 100) /
                              100.0),
                        ),
                      ),

                      const SizedBox(height: AppSizes.fontSizeXl),

                      // Today / Custom radio (Custom selected in screenshot)
                      Obx(
                        () => _RadioRow(
                          leftText: "Today Data",
                          rightText: "Custom Date Data",
                          selectedIndex: controller.dateMode.value,
                          onChanged: (i) => controller.dateMode.value = i,
                        ),
                      ),

                      const SizedBox(height: AppSizes.md + 2),

                      // Date fields row only shown when Custom selected
                      Obx(() {
                        if (controller.dateMode.value != 1) {
                          return const SizedBox(height: AppSizes.sm);
                        }
                        return _DateRow(controller: controller);
                      }),

                      const SizedBox(height: AppSizes.md + 2),

                      // Energy Chart card 1 (20.05 kw)
                      Obx(
                        () => _EnergyChartCard(
                          kw: controller.energyKwTop.value,
                          items: controller.items,
                        ),
                      ),

                      const SizedBox(height: AppSizes.fontSizeXl),

                      // Energy Chart card 2 (5.53 kw)
                      Obx(
                        () => _EnergyChartCard(
                          kw: controller.energyKwBottom.value,
                          items: controller.items,
                        ),
                      ),

                      const SizedBox(height: AppSizes.md + 2),
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

/// ---------- TOP BAR ----------
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
                    color: AppColors.notificationRed,
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

/// ---------- SEGMENT ----------
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
        color: AppColors.white,
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
      borderRadius: BorderRadius.circular(12),
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

/// ---------- SEMI GAUGE ----------
class _SemiGauge extends StatelessWidget {
  const _SemiGauge({
    required this.valueText,
    required this.unitText,
    required this.progress,
  });

  final String valueText;
  final String unitText;
  final double progress;

  static const Color _ink = AppColors.textDarkBlue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          height: 260,
          width: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(260, 170),
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
                    valueText,
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w900,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs + 2),
                  Text(
                    unitText,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: _ink,
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

    const start = math.pi;
    const sweep = math.pi;

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
  bool shouldRepaint(covariant _SemiGaugePainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.valueColor != valueColor ||
      oldDelegate.stroke != stroke;
}

/// ---------- RADIO ROW ----------
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

  static const Color _blue = AppColors.primary;
  static const Color _muted = AppColors.textMuted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () => onChanged(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selectedIndex == 0
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selectedIndex == 0 ? _blue : _muted,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      leftText,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: selectedIndex == 0 ? _muted : _muted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          child: InkWell(
            onTap: () => onChanged(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  selectedIndex == 1
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selectedIndex == 1 ? _blue : _muted,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      rightText,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: selectedIndex == 1 ? _blue : _muted,
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

/// ---------- DATE ROW ----------
class _DateRow extends StatelessWidget {
  const _DateRow({required this.controller});
  final ScreenController controller;

  static const Color _blue = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DateField(hint: "From Date", onTap: controller.pickFromDate),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: _DateField(hint: "To Date", onTap: controller.pickToDate),
        ),
        const SizedBox(width: AppSizes.md),
        InkWell(
          onTap: controller.searchCustomDate,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 62,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
              border: Border.all(color: _blue, width: 1.8),
            ),
            child: const Icon(Icons.search_rounded, color: _blue, size: 30),
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.hint, required this.onTap});

  final String hint;
  final VoidCallback onTap;

  static const Color _border = AppColors.borderLightBlue;
  static const Color _muted = AppColors.textMuted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          border: Border.all(color: _border, width: 1.3),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hint,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: _muted,
                ),
              ),
            ),
            const Icon(Icons.calendar_month_rounded, color: _muted, size: 30),
          ],
        ),
      ),
    );
  }
}

/// ---------- ENERGY CARD (same style as screenshot) ----------
class _EnergyChartCard extends StatelessWidget {
  const _EnergyChartCard({required this.kw, required this.items});

  final double kw;
  final List items; // uses controller.items (EnergyRowModel list)

  static const Color _border = AppColors.borderLightBlue;
  static const Color _ink = AppColors.textDarkBlue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.lg),
        border: Border.all(color: _border, width: 1.3),
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
                      color: _ink,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${kw.toStringAsFixed(2)} kw",
                    style: const TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                      color: _ink,
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
  final dynamic item; // EnergyRowModel

  static const Color _border = AppColors.borderLightBlue;
  static const Color _ink = AppColors.textDarkBlue;
  static const Color _muted = AppColors.textMuted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _border, width: 1.3),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
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
                      color: _ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 54,
            width: 1.2,
            color: _border,
            margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          ),
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
                        color: _muted,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: _muted,
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
                            color: _ink,
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
                        color: _muted,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      ":",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: _muted,
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
                            color: _ink,
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
