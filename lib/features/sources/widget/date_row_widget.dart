import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/controller/screen_controller.dart';
import 'package:scubecms/features/sources/widget/date_field_widget.dart';

class DateRow extends StatelessWidget {
  const DateRow({required this.controller});
  final SourceDataController controller;

  static const Color _blue = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DateField(hint: "From Date", onTap: controller.pickFromDate),
        ),
        const SizedBox(width: AppSizes.xs),
        Expanded(
          child: DateField(hint: "To Date", onTap: controller.pickToDate),
        ),
        const SizedBox(width: AppSizes.xs),
        InkWell(
          onTap: controller.searchCustomDate,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 34,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _blue, width: 1.8),
            ),
            child: const Icon(Icons.search_rounded, color: _blue, size: 18),
          ),
        ),
      ],
    );
  }
}
