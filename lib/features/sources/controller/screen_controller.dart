import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';

class SourceDataController extends GetxController {
  final RxInt topSegment = 0.obs;

  final RxInt dateMode = 0.obs;

  final RxDouble todayGaugeValue = 55.00.obs;
  final RxDouble todayEnergyData = 0.00.obs;
  final RxDouble todayEnergyCost = 0.00.obs;

  final RxDouble customDateGaugeValue = 3.00.obs;
  final RxDouble customDateEnergyData = 0.00.obs;
  final RxDouble customDateEnergyCost = 0.00.obs;

  double gaugeValue() => todayGaugeValue.value + customDateGaugeValue.value;
  double energyData() => todayEnergyData.value + customDateEnergyData.value;
  double energyCost() => todayEnergyCost.value + customDateEnergyCost.value;

  final RxDouble revenueAmount = 0.00.obs;
  final RxDouble costRevenueGaugeValue = 0.00.obs;
  final RxDouble percentRevenueGaugeValue = 0.00.obs;

  final RxDouble totalTodayKw = 5.53.obs;
  final RxDouble totalCustomDateKw = 20.05.obs;

  final todaysItems = <EnergyRowModel>[
    EnergyRowModel(
      name: "Data A",
      dotColor: AppColors.primary.value,
      data: 278.50,
      cost: 35689,
    ),
    EnergyRowModel(
      name: "Data B",
      dotColor: AppColors.chartCyan.value,
      data: 728.50,
      cost: 5259689,
    ),
    EnergyRowModel(
      name: "Data C",
      dotColor: AppColors.chartPurple.value,
      data: 598.36,
      cost: 5698756,
    ),
    EnergyRowModel(
      name: "Data D",
      dotColor: AppColors.chartOrange.value,
      data: 658.26,
      cost: 356987,
    ),
  ].obs;

  final customDateItems = <EnergyRowModel>[
    EnergyRowModel(
      name: "Data A",
      dotColor: AppColors.primary.value,
      data: 2798.50,
      cost: 35689,
    ),
    EnergyRowModel(
      name: "Data B",
      dotColor: AppColors.chartCyan.value,
      data: 72598.50,
      cost: 5259689,
    ),
    EnergyRowModel(
      name: "Data C",
      dotColor: AppColors.chartPurple.value,
      data: 6598.36,
      cost: 5698756,
    ),
    EnergyRowModel(
      name: "Data D",
      dotColor: AppColors.chartOrange.value,
      data: 6598.26,
      cost: 356987,
    ),
  ].obs;

  /// Screen Two
  // Revenue screen
  final RxBool revenueExpanded = true.obs;

  // demo revenue rows
  final revenueRows = <RevenueRow>[
    RevenueRow(data: 3244.50, cost: 3839),
    RevenueRow(data: 1322.50, cost: 2344),
    RevenueRow(data: 3321.50, cost: 2345),
    RevenueRow(data: 1202.50, cost: 6879),
  ].obs;

  final RxInt dateModeStatistics = 1.obs;

  final Rxn<DateTime> fromDate = Rxn<DateTime>();
  final Rxn<DateTime> toDate = Rxn<DateTime>();

  @override
  void onInit() {
    super.onInit();

    _recalcTodayTotals();
    _recalcCustomDateTotals();
    _recalcRevenueTotals();

    ever(todaysItems, (_) => _recalcTodayTotals());
    ever(customDateItems, (_) => _recalcCustomDateTotals());
    ever(revenueRows, (_) => _recalcRevenueTotals());
  }

  void _recalcTodayTotals() {
    final totalData = todaysItems.fold<double>(
      0.0,
      (sum, row) => sum + row.data,
    );
    final totalCost = todaysItems.fold<double>(
      0.0,
      (sum, row) => sum + row.cost.toDouble(),
    );

    todayEnergyData.value = totalData;
    todayEnergyCost.value = totalCost;

    // todayGaugeValue.value = todaysItems.fold<double>(
    //   0.0,
    //   (sum, row) => sum + percentForTodaysItem(row),
    // );
  }

  void _recalcCustomDateTotals() {
    final totalData = customDateItems.fold<double>(
      0.0,
      (sum, row) => sum + row.data,
    );
    final totalCost = customDateItems.fold<double>(
      0.0,
      (sum, row) => sum + row.cost.toDouble(),
    );

    customDateEnergyData.value = totalData;
    customDateEnergyCost.value = totalCost;

    // customDateGaugeValue.value = customDateItems.fold<double>(
    //   0.0,
    //   (sum, row) => sum + percentForCustomItem(row),
    // );
  }

  void _recalcRevenueTotals() {
    final totalData = revenueRows.fold<double>(
      0.0,
      (sum, row) => sum + row.data,
    );
    final totalCost = revenueRows.fold<double>(
      0.0,
      (sum, row) => sum + row.cost.toDouble(),
    );

    revenueAmount.value = totalData;
    costRevenueGaugeValue.value = totalCost;

    percentRevenueGaugeValue.value = revenueRows.fold<double>(
      0.0,
      (sum, row) => sum + percentForRevenueRow(row),
    );
  }

  double _calculatePercent({
    required double data,
    required double cost,
    required double totalData,
    required double totalCost,
  }) {
    double shareSum = 0.0;
    int contributors = 0;
    if (totalData > 0) {
      shareSum += data / totalData;
      contributors++;
    }
    if (totalCost > 0) {
      shareSum += cost / totalCost;
      contributors++;
    }
    if (contributors == 0) return 0.0;
    return (shareSum / contributors) * 100.0;
  }

  double percentForTodaysItem(EnergyRowModel row) => _calculatePercent(
    data: row.data,
    cost: row.cost.toDouble(),
    totalData: todayEnergyData.value,
    totalCost: todayEnergyCost.value,
  );

  double percentForCustomItem(EnergyRowModel row) => _calculatePercent(
    data: row.data,
    cost: row.cost.toDouble(),
    totalData: customDateEnergyData.value,
    totalCost: customDateEnergyCost.value,
  );

  double percentForRevenueRow(RevenueRow row) => _calculatePercent(
    data: row.data,
    cost: row.cost.toDouble(),
    totalData: revenueAmount.value,
    totalCost: costRevenueGaugeValue.value,
  );

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
    required this.cost,
  });

  final String name;
  final int dotColor;
  final double data;
  final int cost;
}

class RevenueRow {
  RevenueRow({required this.data, required this.cost});

  final double data;
  final int cost;
}
