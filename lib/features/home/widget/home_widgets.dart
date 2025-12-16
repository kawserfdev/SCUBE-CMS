
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/core/constants/app_assets.dart';
import 'package:scubecms/features/home/widget/custom_gradient_scrolling_widget.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../routes/app_routes.dart';
import '../controller/home_controller.dart';

class DashboardCardShell extends StatelessWidget {
  const DashboardCardShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.xxl),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: child,
    );
  }
}
class CustomAppBar extends GetView<HomeController>
    implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      title: const Text(
        'SCM',
        style: TextStyle(
          color: Colors.black,
          fontSize: AppSizes.fontSizeLg,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.textDarkBlue,
        ),
        onPressed: () => Get.back(),
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppAssets.notification,
                width: AppSizes.iconMd,
                height: AppSizes.iconMd,
              ),
            ),
            Obx(() => controller.notificationLength.value > 0
                ? Positioned(
                    right: 13,
                    top: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.notificationRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ],
    );
  }
}

class DashboardTabs extends StatelessWidget {
  const DashboardTabs({super.key, required this.onChanged});

  final ValueChanged<int> onChanged;

  static const _blue = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.borderRadiusLg),
          topRight: Radius.circular(AppSizes.borderRadiusLg),
        ),
        border: Border(bottom: BorderSide(color: AppColors.borderLightBlue)),
      ),
      child: TabBar(
        onTap: onChanged,
        dividerColor: Colors.transparent,

        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),

        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: _blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.borderRadius),
            topRight: Radius.circular(AppSizes.borderRadius),
          ),
        ),

        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textGrey,

        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),

        tabs: const [
          Tab(text: "Summary"),
          Tab(text: "SLD"),
          Tab(text: "Data"),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSizes.md),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.sectionTitle,
          ),
        ),
        Divider(color: AppColors.textSecondary, height: 8),
        const SizedBox(height: 6),
      ],
    );
  }
}

class PowerRing extends StatelessWidget {
  const PowerRing({super.key, required this.kw});

  final double kw;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          height: 150,
          width: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 20,
                  backgroundColor: AppColors.ringBackground,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.ringForeground,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Total Power",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textVeryDarkBlue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${kw.toStringAsFixed(2)} kw",
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textDarkBlue,
                      fontWeight: FontWeight.w600,
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

class SourceLoadSegment extends StatelessWidget {
  const SourceLoadSegment({super.key, required this.controller});

  final HomeController controller;

  static const _blue = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final idx = controller.segmentIndex.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          children: [
            Container(
              height: 32,
              margin: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
               
              ),
              // padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.segmentBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _SegmentButton(
                      label: "Source",
                      selected: idx == 0,
                      onTap: () => controller.segmentIndex.value = 0,
                      selectedColor: _blue,
                    ),
                  ),
                  Expanded(
                    child: _SegmentButton(
                      label: "Load",
                      selected: idx == 1,
                      onTap: () => controller.segmentIndex.value = 1,
                      selectedColor: _blue,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: AppColors.border,thickness: 2),
          ],
        ),
      );
    });
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedColor,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected ? selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

class DataListBox extends StatelessWidget {
  const DataListBox({super.key, required this.items});

  final List<HomeDataItem> items;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 360.0;
        final double visibleHeight =
            math.min(items.length * 140.0, maxHeight);

        return GradientScrollbar(
          controller: controller.dataScrollController,
          child: SizedBox(
            height: visibleHeight,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              controller: controller.dataScrollController,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (_, index) => DataTile(item: items[index]),
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSizes.md),
            ),
          ),
        );
      },
    );
  }
}
class DataTile extends StatelessWidget {
  const DataTile({super.key, required this.item});

  final HomeDataItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: () => Get.toNamed(item.routeName),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.tileBackground,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          border: Border.all(color: AppColors.borderLightBlue, width: 1.1),
        ),
        child: Row(
          children: [
            Image.asset(item.iconEmoji, width:  AppSizes.xxl, height: AppSizes.xxl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: item.colorBox,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
      
                      // ✅ Make title flexible
                      Flexible(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textDarkBlue,
                          ),
                        ),
                      ),
      
                      const SizedBox(width: AppSizes.sm),
      
                      // ✅ Status stays compact
                      Flexible(
                        child: Text(
                          item.statusText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize:10,
                            fontWeight: FontWeight.w500,
                            color: item.isActive
                                ? AppColors.primary
                                : AppColors.statusRed,
                          ),
                        ),
                      ),
                    ],
                  ),
      
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Data 1     : ",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: item.data1.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDarkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ))
                  ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Data 2     : ",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: item.data2.toStringAsFixed(2),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDarkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                    )
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: AppColors.iconGrey,
            ),
          ],
        ),
      ),
    );
  }
}

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.xxl,
        vertical: AppSizes.md,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  emoji:AppAssets.chart,
                  label: "Analysis Pro",
                  onTap: () => Get.toNamed(AppRoutes.analysis),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: QuickActionButton(
                  emoji: AppAssets.generator,
                  label: "G. Generator",
                  onTap: () => Get.toNamed(AppRoutes.analysis),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  emoji: AppAssets.charge,
                  label: "Plant Summery",
                  onTap: () => Get.toNamed(AppRoutes.analysis),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: QuickActionButton(
                  emoji:AppAssets.fire,
                  label: "Natural Gas",
                  onTap: () => Get.toNamed(AppRoutes.analysis),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.md),
          Row(
            children: [
              Expanded(
                child: QuickActionButton(emoji: AppAssets.generator, label: "D. Generator", onTap: () => Get.toNamed(AppRoutes.analysis),),
              ),
              SizedBox(width: AppSizes.md),
              Expanded(
                child: QuickActionButton(emoji:AppAssets.faucet, label: "Water Process",onTap: () => Get.toNamed(AppRoutes.analysis),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.emoji,
    required this.label,
    this.onTap,
  });

  final String emoji;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.92),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          border: Border.all(color: AppColors.borderLightBlue, width: 1),
        ),
        child: Row(
          children: [
            Image.asset(emoji, height: 24, width: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoDataView extends StatelessWidget {
  const NoDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Image.asset(AppAssets.noDataFount, height: 200,),
             
            SizedBox(height: 14),
            Text(
              "No data is here,\nplease wait.",
              textAlign: TextAlign.center,  
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF5E5E5E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
