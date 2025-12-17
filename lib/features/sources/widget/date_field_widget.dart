
import 'package:flutter/material.dart';
import 'package:scubecms/core/constants/app_colors.dart';

class DateField extends StatelessWidget {
  const DateField({required this.hint, required this.onTap});

  final String hint;
  final VoidCallback onTap;

  static const Color _border = AppColors.borderLightBlue;
  static const Color _muted = AppColors.textMuted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _border, width: 1.3),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hint,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: _muted,
                ),
              ),
            ),
            const Icon(Icons.calendar_month_outlined, color: _muted, size: 18),
          ],
        ),
      ),
    );
  }
}
