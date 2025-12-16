import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/features/home/widget/home_widgets.dart';
import 'package:scubecms/features/sources/widget/custom_progress.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../controller/screen_controller.dart';

class SourceDataView extends GetView<SourceDataController> {
  const SourceDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLightBlue,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Obx(
                () => Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.xxl),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.92),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizes.xl),
                      topRight: Radius.circular(AppSizes.xl),
                    ),
                    border: Border.all(
                      color: AppColors.borderLightBlue,
                      width: 1.3,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: controller.topSegment.value == 0
                        ? DataViewTab()
                        : RevenueViewTab(),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: AppSizes.xxl,
              right: AppSizes.xxl,
              child: Obx(
                () => _SegmentedPill(
                  leftText: "Data View",
                  rightText: "Revenue View",
                  selectedIndex: controller.topSegment.value,
                  onChanged: (i) => controller.topSegment.value = i,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataViewTab extends GetView<SourceDataController> {
  const DataViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => _SemiGauge(
            valueText: controller.gaugeValue.value.toStringAsFixed(2),
            unitText: "kWh/Sqft",
            progress: _mapGaugeToProgress(controller.gaugeValue.value),
          ),
        ),

        const SizedBox(height: AppSizes.xl * 2),

        Obx(
          () => _RadioRow(
            leftText: "Today Data",
            rightText: "Custom Date Data",
            selectedIndex: controller.dateMode.value,
            onChanged: (i) => controller.dateMode.value = i,
          ),
        ),

        const SizedBox(height: AppSizes.xl),

        // Energy Chart Card
        Obx(
          () => controller.dateMode.value == 0
              ? _TodaysEnergyChartCard(
                  totalKw: controller.totalTodayKw.value,
                  items: controller.todaysItems,
                )
              : Column(children: [
                  Obx(() {
                        if (controller.dateMode.value != 1) {
                          return const SizedBox(height: AppSizes.sm);
                        }
                        return _DateRow(controller: controller);
                      }),
                SizedBox(height: AppSizes.md,),
                _TodaysEnergyChartCard(
                  totalKw: controller.totalTodayKw.value,
                  items: controller.customDateItems,
                ),SizedBox(height: 8,),
                _TodaysEnergyChartCard(
                  totalKw: controller.totalCustomDateKw.value,
                  items: controller.customDateItems,
                ),
              ],)
        ),
        const SizedBox(height: AppSizes.md),
      ],
    );
  }

  double _mapGaugeToProgress(double v) {
    final x = v.clamp(0, 100);
    return x / 100.0;
  }
}

class RevenueViewTab extends GetView<SourceDataController> {
  const RevenueViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
    
        Obx(
          () => _RevenueSemiGauge(
            valueText: controller.gaugeValue.value.toStringAsFixed(2),
            unitText: "tk",
            progress: _mapGaugeToProgress(controller.gaugeValue.value),
          ),
        ),
         const SizedBox(height: AppSizes.md),
        // Data & Cost Info card (collapsible)
                      Obx(
                        () => _RevenueInfoCard(
                          expanded: controller.revenueExpanded.value,
                          onToggle: () => controller.revenueExpanded.value =
                              !controller.revenueExpanded.value,
                          rows: controller.revenueRows,
                        ),
                      ),

                     
      ],
    );
  }

  double _mapGaugeToProgress(double v) {
    final x = v.clamp(0, 100);
    return x / 100.0;
  }
}

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? activeColor : inactiveColor,
            size: 24,
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: selected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

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
      width: 180,
      height: 140,
      child: Stack(
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
            bottom: 8,
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

class _RevenueSemiGauge extends StatelessWidget {
  const _RevenueSemiGauge({
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
            bottom: 8,
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

class _TodaysEnergyChartCard extends StatelessWidget {
  const _TodaysEnergyChartCard({required this.totalKw, required this.items});

  final double totalKw;
  final List<EnergyRowModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Column(
        children: [
          SizedBox(height: AppSizes.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              Text(
                "Energy Chart",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDarkBlue,
                ),
              ),
              //const Spacer(),
              Text(
                "${totalKw.toStringAsFixed(2)} kw",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDarkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.fontSizeXl),
          //Padding(padding: EdgeInsets.symmetric(horizontal: 8, ),child: ,)
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: _EnergyRow(item: e),
            ),
          ),
          SizedBox(height: 8),
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



class _DateRow extends StatelessWidget {
  const _DateRow({required this.controller});
  final SourceDataController controller;

  static const Color _blue = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DateField(hint: "From Date", onTap: controller.pickFromDate),
        ),
        const SizedBox(width: AppSizes.xs),
        Expanded(
          child: _DateField(hint: "To Date", onTap: controller.pickToDate),
        ),
        const SizedBox(width: AppSizes.xs),
        InkWell(
          onTap: controller.searchCustomDate,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 34,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _blue, width: 1.8),
            ),
            child: const Icon(Icons.search_rounded, color: _blue, size: 18),
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
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _border, width: 1.3),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hint,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: _muted,
                ),
              ),
            ),
            const Icon(Icons.calendar_month_outlined, color: _muted, size: 18),
          ],
        ),
      ),
    );
  }
}
