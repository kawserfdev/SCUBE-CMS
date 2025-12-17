
import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_sizes.dart';
import 'package:scubecms/features/sources/widget/line_row_widget.dart';

class InfoPair extends StatelessWidget {
  const InfoPair({
    required this.dataLabel,
    required this.dataValue,
    required this.costLabel,
    required this.costValue,
  });

  final String dataLabel;
  final String dataValue;
  final String costLabel;
  final String costValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LineRow(label: dataLabel, value: dataValue),
        const SizedBox(height: AppSizes.xs),
        LineRow(label: costLabel, value: costValue),
      ],
    );
  }
}
