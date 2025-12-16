import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class HomeController extends GetxController {
    final ScrollController dataScrollController = ScrollController();


  final RxInt tabIndex = 0.obs;

  final RxInt segmentIndex = 0.obs;

  final RxDouble totalPowerKw = 5.53.obs;

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
      ),
      HomeDataItem(
        title: "Data Type 2",
        statusText: "(Active)",
        isActive: true,
        data1: 55505.63,
        data2: 58805.63,
        iconEmoji:  AppAssets.battery ,
        colorBox: AppColors.dataOrange,
      ),
      HomeDataItem(
        title: "Data Type 3",
        statusText: "(Inactive)",
        isActive: false,
        data1: 55505.63,
        data2: 58805.63,
        iconEmoji:  AppAssets.pawer,
        colorBox: AppColors.dataBlue,
      ),
    ]);

    loadItems.assignAll([
      HomeDataItem(
        title: "Load View",
        statusText: "(Active)",
        isActive: true,
        data1: 12005.22,
        data2: 18001.10,
        iconEmoji: AppAssets.solar,
        colorBox: AppColors.dataBlue,
      ),
    ]);
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
  });

  final String title;
  final String statusText;
  final bool isActive;
  final double data1;
  final double data2;
  final String iconEmoji;
  final Color colorBox;
}
