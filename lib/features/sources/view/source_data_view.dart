import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/features/home/widget/home_widgets.dart';
import 'package:scubecms/features/sources/view/tab_view.dart';
import 'package:scubecms/features/sources/widget/segmentedpill_widget.dart';
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
              padding: EdgeInsets.only(top: AppSizes.xl * 2),
              child: Obx(
                () => Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.xxl),
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                () => SegmentedPill(
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

