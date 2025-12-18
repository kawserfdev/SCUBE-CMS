import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/core/constants/app_assets.dart';
import 'package:scubecms/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';

class HomeController extends GetxController {
  final ScrollController dataScrollController = ScrollController();

  final RxInt segmentIndex = 0.obs;

  final RxDouble totalPowerKw = 0.0.obs;

  final RxDouble sourceTotalData1 = 0.0.obs;
  final RxDouble loadTotalData1 = 0.0.obs;

  final RxInt notificationLength = 7.obs;

  final RxList<HomeDataItem> sourceItems = <HomeDataItem>[].obs;
  final RxList<HomeDataItem> loadItems = <HomeDataItem>[].obs;

  final RxBool hasData = true.obs;

  @override
  void onInit() {
    super.onInit();

    sourceItems.assignAll([
      HomeDataItem(
        title: "Data View",
        statusText: "(Active)",
        isActive: true,
        data1: 55505.63,
        data2: 58805.63,
        iconEmoji: AppAssets.solar,
        colorBox: AppColors.dataBlue,
        routeName: AppRoutes.sourceDataView,
      ),
      HomeDataItem(
        title: "Data Type 2",
        statusText: "(Active)",
        isActive: true,
        data1: 55505.63,
        data2: 58805.63,
        iconEmoji: AppAssets.battery,
        colorBox: AppColors.dataOrange,
        routeName: AppRoutes.sourceDataView,
      ),
      HomeDataItem(
        title: "Data Type 3",
        statusText: "(Inactive)",
        isActive: false,
        data1: 55505.63,
        data2: 58805.63,
        iconEmoji: AppAssets.pawer,
        colorBox: AppColors.dataBlue,
        routeName: AppRoutes.sourceDataView,
      ),
      HomeDataItem(
        title: "Data View",
        statusText: "(Active)",
        isActive: true,
        data1: 55505.63,
        data2: 58805.63,
        iconEmoji: AppAssets.solar,
        colorBox: AppColors.dataBlue,
        routeName: AppRoutes.sourceDataView,
      ),
    ]);

    loadItems.assignAll([
      HomeDataItem(
        title: "Load View",
        statusText: "(Active)",
        isActive: true,
        data1: 12005.22,
        data2: 18001.10,
        iconEmoji: AppAssets.pawer,
        colorBox: AppColors.dataBlue,
        routeName: AppRoutes.sourceDataView,
      ),
    ]);

    _recalcSourceTotals();
    _recalcLoadTotals();
    _syncSelectedSegmentView();

    ever<List<HomeDataItem>>(sourceItems, (_) {
      _recalcSourceTotals();
      _syncSelectedSegmentView();
    });

    ever<List<HomeDataItem>>(loadItems, (_) {
      _recalcLoadTotals();
      _syncSelectedSegmentView();
    });

    ever<int>(segmentIndex, (_) => _syncSelectedSegmentView());
  }

  void _recalcSourceTotals() {
    _recalcTotals(sourceItems, sourceTotalData1);
  }

  void _recalcLoadTotals() {
    _recalcTotals(loadItems, loadTotalData1);
  }

  void _recalcTotals(
    List<HomeDataItem> items,
    RxDouble total1,
  ) {
    total1.value = items.fold<double>(
      0.0,
      (sum, item) => sum + item.data1,
    );
  }

  void _syncSelectedSegmentView() {
    final bool isSource = segmentIndex.value == 0;
    totalPowerKw.value = isSource ? sourceTotalData1.value : loadTotalData1.value;
    hasData.value = isSource ? sourceItems.isNotEmpty : loadItems.isNotEmpty;
  }

  @override
  void onClose() {
    dataScrollController.dispose();
    super.onClose();
  }
}

class HomeDataItem {
  HomeDataItem({
    required this.title,
    required this.statusText,
    required this.isActive,
    required this.data1,
    required this.data2,
    required this.iconEmoji,
    required this.colorBox,
    required this.routeName,
  });

  final String title;
  final String statusText;
  final bool isActive;
  final double data1;
  final double data2;
  final String iconEmoji;
  final Color colorBox;
  final String routeName;
}
