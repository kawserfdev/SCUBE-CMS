import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      padding: const EdgeInsets.all(AppSizes.sm + 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(AppSizes.lg),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: AppSizes.lg,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class DashboardTabs extends StatelessWidget {
  const DashboardTabs({super.key, required this.onChanged});

  final ValueChanged<int> onChanged;

  static const _blue = AppColors.primaryBlue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.buttonHeight,
      padding: const EdgeInsets.all(AppSizes.xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.2),
      ),
      child: TabBar(
        onTap: onChanged,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: _blue,
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textGrey,
        labelStyle: const TextStyle(
          fontSize: AppSizes.fontSizeXl,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: AppSizes.fontSizeXl,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: "Summery"),
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
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.sectionTitle,
          ),
        ),
        const SizedBox(height: 10),
        Container(height: 1.2, color: AppColors.borderLightBlue),
        const SizedBox(height: 14),
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
      height: 300,
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          height: 300,
          width: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 230,
                width: 230,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 34,
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
                      fontSize: 22,
                      color: AppColors.textVeryDarkBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    "${kw.toStringAsFixed(2)} kw",
                    style: const TextStyle(
                      fontSize: 34,
                      color: AppColors.textDarkBlue,
                      fontWeight: FontWeight.w800,
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

  static const _blue = AppColors.primaryBlue;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final idx = controller.segmentIndex.value;
      return Container(
        height: AppSizes.appBarHeight,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.segmentBackground,
          borderRadius: BorderRadius.circular(30),
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
        borderRadius: BorderRadius.circular(26),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
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
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.md),
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderLightBlue, width: 1.2),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < items.length - 1 ? AppSizes.md : 0,
            ),
            child: DataTile(item: item),
          );
        }).toList(),
      ),
    );
  }
}

class DataTile extends StatelessWidget {
  const DataTile({super.key, required this.item});

  final HomeDataItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        color: AppColors.tileBackground,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.1),
      ),
      child: Row(
        children: [
          Text(item.iconEmoji, style: const TextStyle(fontSize: 34)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: item.colorBox,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),

                    // ✅ Make title flexible
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24, // slightly smaller to avoid overflow
                          fontWeight: FontWeight.w800,
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
                          fontSize: AppSizes.fontSizeLg,
                          fontWeight: FontWeight.w700,
                          color: item.isActive
                              ? AppColors.primaryBlue
                              : AppColors.statusRed,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Data 1     : ${item.data1.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Data 2     : ${item.data2.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 34,
            color: AppColors.iconGrey,
          ),
        ],
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
        horizontal: AppSizes.md,
        vertical: AppSizes.md,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  emoji: "📊",
                  label: "Analysis Pro",
                  onTap: () => Get.toNamed(AppRoutes.screen1),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: QuickActionButton(
                  emoji: "🧰",
                  label: "G. Generator",
                  onTap: () => Get.toNamed(AppRoutes.screen2),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Row(
            children: [
              Expanded(
                child: QuickActionButton(
                  emoji: "⚡",
                  label: "Plant Summery",
                  onTap: () => Get.toNamed(AppRoutes.screen3),
                ),
              ),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: QuickActionButton(
                  emoji: "🔥",
                  label: "Natural Gas",
                  onTap: () => Get.toNamed(AppRoutes.screen4),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.md),
          Row(
            children: [
              Expanded(
                child: QuickActionButton(emoji: "🧰", label: "D. Generator"),
              ),
              SizedBox(width: AppSizes.md),
              Expanded(
                child: QuickActionButton(emoji: "🚰", label: "Water Process"),
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
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.92),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          border: Border.all(color: AppColors.borderLightBlue, width: 1.1),
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
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
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 110,
              color: AppColors.iconLightGrey,
            ),
            SizedBox(height: 14),
            Text(
              "No data is here,\nplease wait.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5A6575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
