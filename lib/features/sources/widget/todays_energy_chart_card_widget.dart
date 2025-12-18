
import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/controller/screen_controller.dart';
import 'package:scubecms/features/sources/widget/energy_row_widget.dart';

class TodaysEnergyChartCard extends StatelessWidget {
  const TodaysEnergyChartCard({
    required this.totalKw,
    required this.items,
    required this.percentBuilder,
  });

  final double totalKw;
  final List<EnergyRowModel> items;
  final double Function(EnergyRowModel) percentBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderLightBlue, width: 1.3),
      ),
      child: Column(
        children: [
          SizedBox(height: AppSizes.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Energy Chart",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDarkBlue,
                ),
              ),
              //const Spacer(),
              Text(
                "${totalKw.toStringAsFixed(2)} kw",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDarkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.fontSizeXl),
          //Padding(padding: EdgeInsets.symmetric(horizontal: 8, ),child: ,)
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: EnergyRow(item: e, percent: percentBuilder(e)),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
