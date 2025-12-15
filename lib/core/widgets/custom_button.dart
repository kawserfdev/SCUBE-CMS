// import 'package:flutter/material.dart';

// import '../constants/app_colors.dart';
// import '../constants/app_sizes.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton({
//     super.key,
//     required this.label,
//     this.onPressed,
//     this.icon,
//     this.variant = ButtonVariant.filled,
//   });

//   final String label;
//   final VoidCallback? onPressed;
//   final IconData? icon;
//   final ButtonVariant variant;

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final bool isDisabled = onPressed == null;

//     final backgroundColor = switch (variant) {
//       ButtonVariant.filled => isDisabled ? AppColors.border : AppColors.primary,
//       ButtonVariant.outline => Colors.transparent,
//       ButtonVariant.ghost => Colors.transparent,
//     };

//     final borderColor = switch (variant) {
//       ButtonVariant.outline => AppColors.primary,
//       _ => Colors.transparent,
//     };

//     final textColor = switch (variant) {
//       ButtonVariant.filled => Colors.white,
//       ButtonVariant.outline => AppColors.primary,
//       ButtonVariant.ghost => colorScheme.onSurface,
//     };

//     return InkWell(
//       borderRadius: BorderRadius.circular(AppSizes.cardRadius),
//       onTap: onPressed,
//       child: Ink(
//         height: AppSizes.buttonHeight,
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(AppSizes.cardRadius),
//           border: Border.all(color: borderColor),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (icon != null) ...[
//               Icon(icon, color: textColor, size: AppSizes.iconSize),
//               const SizedBox(width: AppSizes.md),
//             ],
//             Text(
//               label,
//               style: Theme.of(
//                 context,
//               ).textTheme.labelLarge?.copyWith(color: textColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// enum ButtonVariant { filled, outline, ghost }
