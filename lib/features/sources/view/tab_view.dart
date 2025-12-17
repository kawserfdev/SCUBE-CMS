import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/controller/screen_controller.dart';
import 'package:scubecms/features/sources/widget/date_row_widget.dart';
import 'package:scubecms/features/sources/widget/radio_row_widget.dart';
import 'package:scubecms/features/sources/widget/revenueInfo_card_widget.dart';
import 'package:scubecms/features/sources/widget/revenue_semi_gauge_widget.dart';
import 'package:scubecms/features/sources/widget/semi_gauge_widget.dart';
import 'package:scubecms/features/sources/widget/todays_energy_chart_card_widget.dart';

class DataViewTab extends GetView<SourceDataController> {
  const DataViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => SemiGauge(
            valueText: controller.gaugeValue.value.toStringAsFixed(2),
            unitText: "kWh/Sqft",
            progress: _mapGaugeToProgress(controller.gaugeValue.value),
          ),
        ),

        const SizedBox(height: AppSizes.xl * 3),

        Obx(
          () => RadioRow(
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
              ? TodaysEnergyChartCard(
                  totalKw: controller.totalTodayKw.value,
                  items: controller.todaysItems,
                )
              : Column(
                  children: [
                    Obx(() {
                      if (controller.dateMode.value != 1) {
                        return const SizedBox(height: AppSizes.sm);
                      }
                      return DateRow(controller: controller);
                    }),
                    SizedBox(height: AppSizes.md),
                    TodaysEnergyChartCard(
                      totalKw: controller.totalTodayKw.value,
                      items: controller.customDateItems,
                    ),
                    SizedBox(height: 8),
                    TodaysEnergyChartCard(
                      totalKw: controller.totalCustomDateKw.value,
                      items: controller.customDateItems,
                    ),
                  ],
                ),
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
          () => RevenueSemiGauge(
            valueText: controller.gaugeValue.value.toStringAsFixed(2),
            unitText: "tk",
            progress: _mapGaugeToProgress(controller.gaugeValue.value),
          ),
        ),
        const SizedBox(height: AppSizes.xxl * 3),
        Obx(
          () => RevenueInfoCard(
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
