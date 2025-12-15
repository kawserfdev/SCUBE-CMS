import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class ScreenController extends GetxController {
  final RxInt topSegment = 0.obs;

  final RxInt dateMode = 0.obs;

  final RxDouble gaugeValue = 55.00.obs; // kWh/Sqft
  final RxDouble totalKw = 5.53.obs;

  final items = <EnergyRowModel>[
    EnergyRowModel(
      name: "Data A",
      dotColor: AppColors.activeBlue.value,
      data: 2798.50,
      percent: 29.53,
      cost: 35689,
    ),
    EnergyRowModel(
      name: "Data B",
      dotColor: AppColors.chartCyan.value,
      data: 72598.50,
      percent: 35.39,
      cost: 5259689,
    ),
    EnergyRowModel(
      name: "Data C",
      dotColor: AppColors.chartPurple.value,
      data: 6598.36,
      percent: 83.90,
      cost: 5698756,
    ),
    EnergyRowModel(
      name: "Data D",
      dotColor: AppColors.chartOrange.value,
      data: 6598.26,
      percent: 36.59,
      cost: 356987,
    ),
  ].obs;

  /// Screen Two
  // Revenue screen
  final RxDouble revenueValue = 8897455.0.obs; // center number
  final RxBool revenueExpanded = true.obs;

  // demo revenue rows
  final revenueRows = <RevenueRow>[
    RevenueRow(data: 2798.50, percent: 29.53, cost: 35689),
    RevenueRow(data: 2798.50, percent: 29.53, cost: 35689),
    RevenueRow(data: 2798.50, percent: 29.53, cost: 35689),
    RevenueRow(data: 2798.50, percent: 29.53, cost: 35689),
  ].obs;

  /// Screen Four
  final RxDouble dataGaugeValue = 57.00.obs; // 57.00 kWh/Sqft
  final RxDouble energyKwTop = 20.05.obs; // first card
  final RxDouble energyKwBottom = 5.53.obs; // second card

  final RxInt dateModeStatistics = 1.obs; // 0=Today Data, 1=Custom Date Data

  final Rxn<DateTime> fromDate = Rxn<DateTime>();
  final Rxn<DateTime> toDate = Rxn<DateTime>();

  Future<void> pickFromDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: fromDate.value ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) fromDate.value = picked;
  }

  Future<void> pickToDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: toDate.value ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) toDate.value = picked;
  }

  void searchCustomDate() {
    // TODO: call API using fromDate/toDate
  }
}

class EnergyRowModel {
  EnergyRowModel({
    required this.name,
    required this.dotColor,
    required this.data,
    required this.percent,
    required this.cost,
  });

  final String name;
  final int dotColor;
  final double data;
  final double percent;
  final int cost;
}

class RevenueRow {
  RevenueRow({required this.data, required this.percent, required this.cost});
  final double data;
  final double percent;
  final int cost;
}
