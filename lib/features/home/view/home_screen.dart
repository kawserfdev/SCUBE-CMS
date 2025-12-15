import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../controller/home_controller.dart';
import '../widget/home_widgets.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const _bg = AppColors.backgroundLightBlue;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            children: [
              // Top bar (back + title + bell with red dot)
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: AppColors.textDarkBlue,
                    ),
                    const Spacer(),
                    const Text(
                      "SCM",
                      style: TextStyle(
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            size: AppSizes.iconMd,
                          ),
                          color: AppColors.textDarkBlue,
                        ),
                        Positioned(
                          right: AppSizes.md,
                          top: AppSizes.sm,
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
              ),

              const SizedBox(height: AppSizes.xs),

              // Main dashboard card
              Expanded(
                child: DashboardCardShell(
                  child: Column(
                    children: [
                      DashboardTabs(
                        onChanged: (i) => controller.tabIndex.value = i,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [_summaryTab(), _sldTab(), _dataTab()],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom quick actions
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

      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 14),
        child: Column(
          children: [
            const SectionTitle(title: "Electricity"),
            PowerRing(kw: controller.totalPowerKw.value),
            const SizedBox(height: AppSizes.sm),
            SourceLoadSegment(controller: controller),
            const SizedBox(height: AppSizes.md),
            DataListBox(items: items),
          ],
        ),
      );
    });
  }

  Widget _sldTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 14),
      child: Column(
        children: [
          const SectionTitle(title: "Single Line Diagram"),
          const SizedBox(height: 20),
          // Simple Schematic Visualization
          Container(
            padding: const EdgeInsets.all(16),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.sourceItems
                      .take(2)
                      .map((e) => _SldNode(icon: e.iconEmoji, label: e.title))
                      .toList(),
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
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadiusSm,
                    ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.loadItems
                      .take(2)
                      .map((e) => _SldNode(icon: e.iconEmoji, label: e.title))
                      .toList(),
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
          DataTile(
            item: HomeDataItem(
              title: "Main Bus Status",
              statusText: "Normal",
              isActive: true,
              data1: 230.5,
              data2: 50.0,
              iconEmoji: "🔌",
              colorBox: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 14),
      child: Column(
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
    );
  }
}

class _SldNode extends StatelessWidget {
  const _SldNode({required this.icon, required this.label});
  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.tileBackground,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryBlue, width: 2),
          ),
          child: Text(icon, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.fontSizeSm,
            color: AppColors.textDarkBlue,
          ),
        ),
      ],
    );
  }
}
