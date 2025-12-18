import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/core/constants/app_assets.dart';
import 'package:scubecms/features/home/widget/sldnode_widget.dart';
import 'package:scubecms/routes/app_routes.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../controller/home_controller.dart';
import '../widget/home_widgets.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(),

        backgroundColor: AppColors.backgroundLightBlue,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppSizes.md),

              Expanded(
                child: DashboardCardShell(
                  child: Column(
                    children: [
                      DashboardTabs(onChanged: (_) {}),
                      Expanded(
                        child: TabBarView(
                          children: [_summaryTab(), _sldTab(), _dataTab()],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const QuickActionsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryTab() {
    return Obx(() {
      if (!controller.hasData.value) {
        return const NoDataView();
      }

      final items = controller.segmentIndex.value == 0
          ? controller.sourceItems
          : controller.loadItems;

      return Column(
        children: [
          const SectionTitle(title: "Electricity"),
          const SizedBox(height: AppSizes.md),
          PowerRing(kw: controller.totalPowerKw.value),
          const SizedBox(height: AppSizes.lg),
          SourceLoadSegment(controller: controller),
          Expanded(child: DataListBox(items: items)),
        ],
      );
    });
  }

  Widget _sldTab() {
    return Column(
      children: [
        const SectionTitle(title: "Single Line Diagram"),
        const SizedBox(height: AppSizes.md),
        Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(.92),
            borderRadius: BorderRadius.circular(AppSizes.lg),
            border: Border.all(color: AppColors.borderLightBlue),
          ),
          child: Column(
            children: [
              const Text(
                "SOURCE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.sourceItems
                      .take(2)
                      .map((e) => SldNode(icon: e.iconEmoji, label: e.title))
                      .toList(),
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              Container(height: 40, width: 2, color: AppColors.textDarkBlue),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.sm,
                  horizontal: AppSizes.xl,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textDarkBlue,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
                ),
                child: const Text(
                  "MAIN BUS",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(height: 40, width: 2, color: AppColors.textDarkBlue),
              const SizedBox(height: 10),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.loadItems
                      .take(2)
                      .map((e) => SldNode(icon: e.iconEmoji, label: e.title))
                      .toList(),
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              const Text(
                "LOAD",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DataTile(
            item: HomeDataItem(
              title: "Main Bus Status",
              statusText: "Normal",
              isActive: true,
              data1: 230.5,
              data2: 50.0,
              iconEmoji: AppAssets.charge,
              colorBox: AppColors.primary,
              routeName: AppRoutes.analysis,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dataTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(
        () => Column(
          children: [
            const SectionTitle(title: "System Data"),
            ...controller.sourceItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DataTile(item: item),
              ),
            ),
            ...controller.loadItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: DataTile(item: item),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
